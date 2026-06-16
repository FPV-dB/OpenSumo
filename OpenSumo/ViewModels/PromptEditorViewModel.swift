import AppKit
import Foundation

@MainActor
final class PromptEditorViewModel: ObservableObject {
    @Published private(set) var presets: [PromptPreset]
    @Published var selectedSection: String = "Style"
    @Published var selectedPresetID: PromptPreset.ID?
    @Published var currentPreset: PromptPreset {
        didSet {
            guard !isUpdatingPrompt else { return }
            refreshGeneratedPrompt()
            autosaveCurrentPreset()
        }
    }
    @Published var negativePrompt: String = ""
    @Published var storeError: String?

    private let store: PresetStore
    private let generator: PromptGenerator
    private var wordingVariant = 0
    private var isUpdatingPrompt = false

    init(store: PresetStore = PresetStore(), generator: PromptGenerator = PromptGenerator()) {
        self.store = store
        self.generator = generator
        let loaded = store.loadPresets()
        presets = loaded
        currentPreset = loaded.first ?? .empty
        selectedPresetID = currentPreset.id
        refreshGeneratedPrompt()
    }

    var wordCount: Int {
        currentPreset.generatedPrompt
            .split { $0.isWhitespace || $0.isNewline }
            .count
    }

    var promptStrength: PromptDetailLevel {
        currentPreset.detailLevel
    }

    func selectPreset(_ id: PromptPreset.ID) {
        guard let preset = presets.first(where: { $0.id == id }) else { return }
        selectedPresetID = id
        currentPreset = preset
    }

    func newPrompt() {
        var preset = PromptPreset.empty
        preset.name = uniqueName("Untitled Prompt")
        preset.generatedPrompt = generator.generate(from: preset)
        presets.insert(preset, at: 0)
        selectedPresetID = preset.id
        currentPreset = preset
        saveAllPresets()
    }

    func savePreset() {
        upsertCurrentPreset()
        saveAllPresets()
    }

    func duplicatePreset() {
        var copy = currentPreset
        copy.id = UUID()
        copy.name = uniqueName("\(currentPreset.name) Copy")
        presets.insert(copy, at: 0)
        selectedPresetID = copy.id
        currentPreset = copy
        saveAllPresets()
    }

    func randomisePrompt() {
        var preset = PromptPreset.empty
        preset.id = UUID()
        preset.name = uniqueName("Random Prompt")
        preset.genres = randomSelection(from: PromptOptions.contemporaryGenres, count: Int.random(in: 1...2))
        if Bool.random() {
            preset.genres += randomSelection(from: PromptOptions.ethnicMusicStyles, count: Int.random(in: 1...3))
        }
        preset.moods = randomSelection(from: PromptOptions.moods, count: Int.random(in: 2...4))
        preset.bpm = Double(Int.random(in: 52...190))
        preset.key = PromptOptions.keys.randomElement() ?? "C"
        preset.mode = PromptOptions.modes.randomElement() ?? "Ionian / major"
        preset.timeSignature = PromptOptions.timeSignatures.randomElement() ?? "4/4"
        preset.alternateTimeSignatures = Bool.random() ? randomSelection(from: PromptOptions.timeSignatures.filter { $0 != preset.timeSignature }, count: Int.random(in: 1...3)) : []
        preset.tempoFeel = PromptOptions.tempoFeels.randomElement() ?? "straight"
        preset.tempoMap = PromptOptions.tempoMaps.randomElement() ?? "steady tempo"
        preset.swingAmount = Double.random(in: 0...0.75)
        preset.tempoHumanization = Double.random(in: 0...0.65)
        preset.vocalType = PromptOptions.vocalTypes.randomElement() ?? "Female lead"
        preset.vocalStyles = preset.vocalType == "Instrumental" ? [] : randomSelection(from: PromptOptions.vocalStyles, count: Int.random(in: 1...4))
        preset.vocalDistance = Double.random(in: 0...1)
        preset.vocalIntensity = Double.random(in: 0.15...1)
        preset.instruments = randomSelection(from: PromptOptions.instruments, count: Int.random(in: 3...7))
        preset.reverbType = PromptOptions.reverbTypes.randomElement() ?? "hall"
        preset.reverbAmount = Double.random(in: 0.12...0.95)
        preset.delayType = PromptOptions.delayTypes.randomElement() ?? "none"
        preset.saturationType = PromptOptions.saturationTypes.randomElement() ?? "tape warmth"
        preset.stereoWidth = Double.random(in: 0.25...0.95)
        preset.dynamics = PromptOptions.dynamicsTypes.randomElement() ?? "balanced"
        preset.effects = randomSelection(from: PromptOptions.effects, count: Int.random(in: 0...4))
        preset.arrangementSections = randomArrangement()
        preset.detailLevel = PromptDetailLevel.allCases.randomElement() ?? .detailed
        preset.frontLoadEnabled = Bool.random()
        preset.frontLoadText = preset.frontLoadEnabled ? frontLoadPhrase(for: preset) : ""
        preset.artistNameSafeMode = true
        preset.generatedPrompt = generator.generate(from: preset, variant: wordingVariant)
        presets.insert(preset, at: 0)
        selectedPresetID = preset.id
        currentPreset = preset
        saveAllPresets()
    }

    func deletePreset() {
        guard presets.count > 1 else {
            newPrompt()
            return
        }
        presets.removeAll { $0.id == currentPreset.id }
        let fallback = presets.first ?? .empty
        selectedPresetID = fallback.id
        currentPreset = fallback
        saveAllPresets()
    }

    func clearPrompt() {
        currentPreset = .empty
        currentPreset.name = uniqueName("Untitled Prompt")
        selectedPresetID = currentPreset.id
        upsertCurrentPreset()
        saveAllPresets()
    }

    func regenerateWording() {
        wordingVariant += 1
        refreshGeneratedPrompt()
        autosaveCurrentPreset()
    }

    func copyPromptToClipboard() {
        NSPasteboard.general.clearContents()
        NSPasteboard.general.setString(currentPreset.generatedPrompt, forType: .string)
    }

    func toggle(_ value: String, in keyPath: WritableKeyPath<PromptPreset, [String]>) {
        var values = currentPreset[keyPath: keyPath]
        if values.contains(value) {
            values.removeAll { $0 == value }
        } else {
            values.append(value)
        }
        currentPreset[keyPath: keyPath] = values
    }

    func addArrangementSection(_ section: String) {
        currentPreset.arrangementSections.append(section)
    }

    func removeArrangementSection(at offsets: IndexSet) {
        currentPreset.arrangementSections.remove(atOffsets: offsets)
    }

    func moveArrangementSection(from source: IndexSet, to destination: Int) {
        currentPreset.arrangementSections.move(fromOffsets: source, toOffset: destination)
    }

    private func refreshGeneratedPrompt() {
        isUpdatingPrompt = true
        currentPreset.generatedPrompt = generator.generate(from: currentPreset, variant: wordingVariant)
        negativePrompt = generator.negativePrompt(from: currentPreset)
        isUpdatingPrompt = false
    }

    private func autosaveCurrentPreset() {
        upsertCurrentPreset()
        saveAllPresets()
    }

    private func upsertCurrentPreset() {
        if let index = presets.firstIndex(where: { $0.id == currentPreset.id }) {
            presets[index] = currentPreset
        } else {
            presets.insert(currentPreset, at: 0)
        }
        selectedPresetID = currentPreset.id
    }

    private func saveAllPresets() {
        do {
            try store.savePresets(presets)
            storeError = nil
        } catch {
            storeError = error.localizedDescription
        }
    }

    private func uniqueName(_ base: String) -> String {
        let names = Set(presets.map(\.name))
        guard names.contains(base) else { return base }
        var counter = 2
        while names.contains("\(base) \(counter)") {
            counter += 1
        }
        return "\(base) \(counter)"
    }

    private func randomSelection(from options: [String], count: Int) -> [String] {
        Array(options.shuffled().prefix(max(0, min(count, options.count))))
    }

    private func randomArrangement() -> [String] {
        var sections = ["Intro", "Verse", "Chorus"]
        let middle = randomSelection(from: ["Pre-Chorus", "Bridge", "Breakdown", "Instrumental", "Solo"], count: Int.random(in: 1...3))
        sections.append(contentsOf: middle)
        sections.append(Bool.random() ? "Final Chorus" : "Outro")
        if sections.last != "Outro", Bool.random() {
            sections.append("Outro")
        }
        return sections
    }

    private func frontLoadPhrase(for preset: PromptPreset) -> String {
        let genre = preset.genres.first?.lowercased() ?? "genre-blending"
        let mood = preset.moods.first?.lowercased() ?? "cinematic"
        return "\(mood) \(genre) hook first, make the core identity obvious immediately"
    }
}

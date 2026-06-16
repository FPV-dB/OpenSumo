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
}

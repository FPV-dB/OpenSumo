import Foundation

struct PresetStore {
    private let encoder: JSONEncoder
    private let decoder: JSONDecoder

    init() {
        encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        decoder = JSONDecoder()
    }

    var presetsURL: URL {
        let base = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first
            ?? FileManager.default.homeDirectoryForCurrentUser
        return base.appendingPathComponent("OpenSumo", isDirectory: true).appendingPathComponent("presets.json")
    }

    func loadPresets() -> [PromptPreset] {
        do {
            let url = presetsURL
            guard FileManager.default.fileExists(atPath: url.path) else {
                try savePresets(PromptPreset.starterPresets)
                return PromptPreset.starterPresets
            }
            let data = try Data(contentsOf: url)
            let presets = try decoder.decode([PromptPreset].self, from: data)
            guard !presets.isEmpty else { return PromptPreset.starterPresets }
            let merged = mergedWithStarterPresets(presets)
            if merged.count != presets.count {
                try? savePresets(merged)
            }
            return merged
        } catch {
            return PromptPreset.starterPresets
        }
    }

    func savePresets(_ presets: [PromptPreset]) throws {
        let url = presetsURL
        try FileManager.default.createDirectory(at: url.deletingLastPathComponent(), withIntermediateDirectories: true)
        let data = try encoder.encode(presets)
        try data.write(to: url, options: [.atomic])
    }

    private func mergedWithStarterPresets(_ presets: [PromptPreset]) -> [PromptPreset] {
        let existingNames = Set(presets.map(\.name))
        let missingStarters = PromptPreset.starterPresets.filter { !existingNames.contains($0.name) }
        return presets + missingStarters
    }
}

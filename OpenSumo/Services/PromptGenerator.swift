import Foundation

struct PromptGenerator {
    func generate(from preset: PromptPreset, variant: Int = 0) -> String {
        var parts: [String] = []
        let frontLoad = preset.frontLoadText.trimmingCharacters(in: .whitespacesAndNewlines)

        if preset.frontLoadEnabled, !frontLoad.isEmpty {
            parts.append(frontLoad)
        }

        parts.append("\(Int(preset.bpm.rounded())) BPM")
        parts.append(preset.key)
        parts.append("\(preset.timeSignature) time")

        if !preset.genres.isEmpty {
            let joinedGenres = naturalList(preset.genres.map { $0.lowercased() })
            let styleSuffix = preset.artistNameSafeMode ? "using descriptive genre language" : "with bold reference-ready styling"
            parts.append("\(joinedGenres) \(stylePhrase(for: preset.detailLevel, variant: variant)), \(styleSuffix)")
        }

        if preset.vocalType != "Instrumental" {
            var vocal = preset.vocalType.lowercased()
            if !preset.vocalStyles.isEmpty {
                vocal += " vocal with \(naturalList(preset.vocalStyles))"
            } else {
                vocal += " vocal"
            }
            vocal += ", \(distancePhrase(preset.vocalDistance)), \(intensityPhrase(preset.vocalIntensity))"
            parts.append(vocal)
        } else {
            parts.append("instrumental focus with expressive lead melodies")
        }

        if !preset.instruments.isEmpty {
            parts.append(naturalList(preset.instruments))
        }

        parts.append("\(amountPhrase(preset.reverbAmount)) \(preset.reverbType) reverb")
        if preset.delayType != "none" {
            parts.append(preset.delayType)
        }
        parts.append("\(preset.saturationType) saturation")
        parts.append("\(widthPhrase(preset.stereoWidth)) stereo image")
        parts.append("\(preset.dynamics) production")

        if !preset.effects.isEmpty {
            parts.append(naturalList(preset.effects))
        }

        if !preset.moods.isEmpty {
            parts.append(naturalList(preset.moods.map { $0.lowercased() }))
        }

        if preset.detailLevel != .simple, !preset.arrangementSections.isEmpty {
            parts.append("arrangement flows through \(preset.arrangementSections.joined(separator: " -> "))")
        }

        if preset.detailLevel == .extreme {
            parts.append("clear contrast between sections, memorable motif development, evolving texture, strong transitions")
        }

        let notes = preset.customNotes.trimmingCharacters(in: .whitespacesAndNewlines)
        if !notes.isEmpty {
            parts.append(notes)
        }

        let avoid = preset.avoidTags.trimmingCharacters(in: .whitespacesAndNewlines)
        if !avoid.isEmpty {
            parts.append("avoid \(avoid)")
        }

        return parts
            .filter { !$0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }
            .joined(separator: ", ")
            .replacingOccurrences(of: "  ", with: " ")
            .trimmingCharacters(in: .whitespacesAndNewlines)
    }

    func negativePrompt(from preset: PromptPreset) -> String {
        let avoid = preset.avoidTags.trimmingCharacters(in: .whitespacesAndNewlines)
        let base = "avoid muddy mixes, weak hooks, flat dynamics, clipped vocals, generic lyrics"
        return avoid.isEmpty ? base : "\(base), \(avoid)"
    }

    private func naturalList(_ values: [String]) -> String {
        let clean = values.filter { !$0.isEmpty }
        guard clean.count > 1 else { return clean.first ?? "" }
        return clean.dropLast().joined(separator: ", ") + " and " + (clean.last ?? "")
    }

    private func stylePhrase(for detailLevel: PromptDetailLevel, variant: Int) -> String {
        switch (detailLevel, variant % 3) {
        case (.simple, _): "song"
        case (.detailed, 1): "with vivid production detail"
        case (.detailed, 2): "with cinematic arrangement detail"
        case (.extreme, 1): "with highly specific arrangement, texture and mix direction"
        case (.extreme, 2): "with forensic production notes and evolving sonic layers"
        default: "with polished modern production"
        }
    }

    private func distancePhrase(_ value: Double) -> String {
        switch value {
        case ..<0.25: "very intimate and close-mic'd"
        case ..<0.55: "present and personal"
        case ..<0.78: "slightly distant and atmospheric"
        default: "distant and spacious"
        }
    }

    private func intensityPhrase(_ value: Double) -> String {
        switch value {
        case ..<0.25: "restrained delivery"
        case ..<0.55: "controlled emotional delivery"
        case ..<0.8: "building to powerful peaks"
        default: "explosive vocal intensity"
        }
    }

    private func amountPhrase(_ value: Double) -> String {
        switch value {
        case ..<0.25: "subtle"
        case ..<0.55: "moderate"
        case ..<0.8: "lush"
        default: "massive"
        }
    }

    private func widthPhrase(_ value: Double) -> String {
        switch value {
        case ..<0.25: "narrow"
        case ..<0.55: "focused"
        case ..<0.8: "wide"
        default: "ultra-wide"
        }
    }
}

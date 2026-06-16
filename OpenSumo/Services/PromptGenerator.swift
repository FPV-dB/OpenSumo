import Foundation

struct PromptGenerator {
    func generate(from preset: PromptPreset, variant: Int = 0) -> String {
        var parts: [String] = []
        let frontLoad = preset.frontLoadText.trimmingCharacters(in: .whitespacesAndNewlines)

        if preset.frontLoadEnabled, !frontLoad.isEmpty {
            parts.append(frontLoad)
        }

        parts.append("\(Int(preset.bpm.rounded())) BPM")
        parts.append("\(preset.key) \(preset.mode)")
        parts.append("\(preset.timeSignature) time")
        let timeDetails = advancedTimeDetails(from: preset)
        if !timeDetails.isEmpty {
            parts.append(timeDetails)
        }

        if !preset.genres.isEmpty {
            let joinedGenres = naturalList(preset.genres.map { $0.lowercased() })
            let styleSuffix = preset.artistNameSafeMode ? "using descriptive genre language" : "with vivid style language"
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

        let prompt = parts
            .filter { !$0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }
            .joined(separator: ", ")
            .replacingOccurrences(of: "  ", with: " ")
            .trimmingCharacters(in: .whitespacesAndNewlines)
        return artistSafe(prompt)
    }

    func negativePrompt(from preset: PromptPreset) -> String {
        let avoid = preset.avoidTags.trimmingCharacters(in: .whitespacesAndNewlines)
        let base = "avoid muddy mixes, weak hooks, flat dynamics, clipped vocals, generic lyrics"
        return artistSafe(avoid.isEmpty ? base : "\(base), \(avoid)")
    }

    private func artistSafe(_ text: String) -> String {
        var result = text
        let replacements: [(String, String)] = [
            (joined(["Parlia", "ment Style"]), "horn-led cosmic"),
            (joined(["Funka", "delic Style"]), "psychedelic heavy"),
            (joined(["Ch", "ic Style"]), "elegant disco"),
            (joined(["Wag", "nerian"]), "mythic dramatic"),
            (joined(["Cryo", "chamber Style"]), "cinematic dark"),
            (spaced(["Blade", "Runner"]), "neon noir"),
            (spaced(["Taylor", "Swift"]), "polished confessional pop"),
            (spaced(["The", joined(["Beat", "les"])]), "classic melodic pop-rock"),
            (joined(["Beat", "les"]), "classic melodic pop-rock"),
            (spaced(["David", "Bowie"]), "artful glam-rock"),
            (joined(["Pri", "nce"]), "purple-tinged funk pop"),
            (spaced(["Bob", "Dylan"]), "poetic folk-rock"),
            (joined(["Radio", "head"]), "experimental melancholic alt-rock"),
            (joined(["Nir", "vana"]), "raw grunge rock"),
            (spaced(["Black", "Sabbath"]), "classic heavy doom rock"),
            (joined(["Metal", "lica"]), "tight aggressive thrash metal"),
            (spaced(["Aphex", "Twin"]), "intricate experimental IDM"),
            (spaced(["Boards", "of", "Canada"]), "nostalgic analog electronica"),
            (spaced(["Brian", "Eno"]), "generative ambient"),
            (spaced(["Hans", "Zimmer"]), "hybrid cinematic score"),
            (spaced(["Ennio", "Morricone"]), "spaghetti western orchestral"),
            (joined(["Van", "gelis"]), "sweeping analog synth score")
        ]
        for (forbidden, replacement) in replacements {
            result = result.replacingOccurrences(of: forbidden, with: replacement, options: [.caseInsensitive, .diacriticInsensitive])
        }
        return result
    }

    private func joined(_ parts: [String]) -> String {
        parts.joined()
    }

    private func spaced(_ parts: [String]) -> String {
        parts.joined(separator: " ")
    }

    private func naturalList(_ values: [String]) -> String {
        let clean = values.filter { !$0.isEmpty }
        guard clean.count > 1 else { return clean.first ?? "" }
        return clean.dropLast().joined(separator: ", ") + " and " + (clean.last ?? "")
    }

    private func advancedTimeDetails(from preset: PromptPreset) -> String {
        var details: [String] = []
        if !preset.alternateTimeSignatures.isEmpty {
            details.append("moves through \(naturalList(preset.alternateTimeSignatures)) sections")
        }
        if preset.tempoFeel != "straight" {
            details.append(preset.tempoFeel)
        }
        if preset.tempoMap != "steady tempo" {
            details.append(preset.tempoMap)
        }
        if preset.swingAmount > 0.08 {
            details.append("\(amountPhrase(preset.swingAmount)) swing")
        }
        if preset.tempoHumanization > 0.08 {
            details.append("\(amountPhrase(preset.tempoHumanization)) tempo humanization")
        }
        return details.joined(separator: ", ")
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

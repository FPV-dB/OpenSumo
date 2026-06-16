import Foundation

struct PromptPreset: Identifiable, Codable, Equatable {
    var id: UUID
    var name: String
    var genres: [String]
    var moods: [String]
    var bpm: Double
    var key: String
    var timeSignature: String
    var vocalType: String
    var vocalStyles: [String]
    var vocalDistance: Double
    var vocalIntensity: Double
    var instruments: [String]
    var reverbType: String
    var reverbAmount: Double
    var delayType: String
    var saturationType: String
    var stereoWidth: Double
    var dynamics: String
    var effects: [String]
    var arrangementSections: [String]
    var detailLevel: PromptDetailLevel
    var frontLoadEnabled: Bool
    var frontLoadText: String
    var avoidTags: String
    var customNotes: String
    var artistNameSafeMode: Bool
    var generatedPrompt: String

    init(
        id: UUID = UUID(),
        name: String,
        genres: [String] = [],
        moods: [String] = [],
        bpm: Double = 92,
        key: String = "B minor",
        timeSignature: String = "4/4",
        vocalType: String = "Female lead",
        vocalStyles: [String] = [],
        vocalDistance: Double = 0.25,
        vocalIntensity: Double = 0.55,
        instruments: [String] = [],
        reverbType: String = "hall",
        reverbAmount: Double = 0.55,
        delayType: String = "none",
        saturationType: String = "tape warmth",
        stereoWidth: Double = 0.62,
        dynamics: String = "balanced",
        effects: [String] = [],
        arrangementSections: [String] = ["Intro", "Verse", "Chorus", "Outro"],
        detailLevel: PromptDetailLevel = .detailed,
        frontLoadEnabled: Bool = false,
        frontLoadText: String = "",
        avoidTags: String = "",
        customNotes: String = "",
        artistNameSafeMode: Bool = true,
        generatedPrompt: String = ""
    ) {
        self.id = id
        self.name = name
        self.genres = genres
        self.moods = moods
        self.bpm = bpm
        self.key = key
        self.timeSignature = timeSignature
        self.vocalType = vocalType
        self.vocalStyles = vocalStyles
        self.vocalDistance = vocalDistance
        self.vocalIntensity = vocalIntensity
        self.instruments = instruments
        self.reverbType = reverbType
        self.reverbAmount = reverbAmount
        self.delayType = delayType
        self.saturationType = saturationType
        self.stereoWidth = stereoWidth
        self.dynamics = dynamics
        self.effects = effects
        self.arrangementSections = arrangementSections
        self.detailLevel = detailLevel
        self.frontLoadEnabled = frontLoadEnabled
        self.frontLoadText = frontLoadText
        self.avoidTags = avoidTags
        self.customNotes = customNotes
        self.artistNameSafeMode = artistNameSafeMode
        self.generatedPrompt = generatedPrompt
    }
}

extension PromptPreset {
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case genres
        case moods
        case bpm
        case key
        case timeSignature
        case vocalType
        case vocalStyles
        case vocalDistance
        case vocalIntensity
        case instruments
        case reverbType
        case reverbAmount
        case delayType
        case saturationType
        case stereoWidth
        case dynamics
        case effects
        case arrangementSections
        case detailLevel
        case frontLoadEnabled
        case frontLoadText
        case avoidTags
        case customNotes
        case artistNameSafeMode
        case generatedPrompt
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        genres = try container.decodeIfPresent([String].self, forKey: .genres) ?? []
        moods = try container.decodeIfPresent([String].self, forKey: .moods) ?? []
        bpm = try container.decodeIfPresent(Double.self, forKey: .bpm) ?? 92
        key = try container.decodeIfPresent(String.self, forKey: .key) ?? "B minor"
        timeSignature = try container.decodeIfPresent(String.self, forKey: .timeSignature) ?? "4/4"
        vocalType = try container.decodeIfPresent(String.self, forKey: .vocalType) ?? "Female lead"
        vocalStyles = try container.decodeIfPresent([String].self, forKey: .vocalStyles) ?? []
        vocalDistance = try container.decodeIfPresent(Double.self, forKey: .vocalDistance) ?? 0.25
        vocalIntensity = try container.decodeIfPresent(Double.self, forKey: .vocalIntensity) ?? 0.55
        instruments = try container.decodeIfPresent([String].self, forKey: .instruments) ?? []
        reverbType = try container.decodeIfPresent(String.self, forKey: .reverbType) ?? "hall"
        reverbAmount = try container.decodeIfPresent(Double.self, forKey: .reverbAmount) ?? 0.55
        delayType = try container.decodeIfPresent(String.self, forKey: .delayType) ?? "none"
        saturationType = try container.decodeIfPresent(String.self, forKey: .saturationType) ?? "tape warmth"
        stereoWidth = try container.decodeIfPresent(Double.self, forKey: .stereoWidth) ?? 0.62
        dynamics = try container.decodeIfPresent(String.self, forKey: .dynamics) ?? "balanced"
        effects = try container.decodeIfPresent([String].self, forKey: .effects) ?? []
        arrangementSections = try container.decodeIfPresent([String].self, forKey: .arrangementSections) ?? ["Intro", "Verse", "Chorus", "Outro"]
        detailLevel = try container.decodeIfPresent(PromptDetailLevel.self, forKey: .detailLevel) ?? .detailed
        frontLoadEnabled = try container.decodeIfPresent(Bool.self, forKey: .frontLoadEnabled) ?? false
        frontLoadText = try container.decodeIfPresent(String.self, forKey: .frontLoadText) ?? ""
        avoidTags = try container.decodeIfPresent(String.self, forKey: .avoidTags) ?? ""
        customNotes = try container.decodeIfPresent(String.self, forKey: .customNotes) ?? ""
        artistNameSafeMode = try container.decodeIfPresent(Bool.self, forKey: .artistNameSafeMode) ?? true
        generatedPrompt = try container.decodeIfPresent(String.self, forKey: .generatedPrompt) ?? ""
    }
}

enum PromptDetailLevel: String, CaseIterable, Identifiable, Codable {
    case simple = "Simple"
    case detailed = "Detailed"
    case extreme = "Extreme"

    var id: String { rawValue }
}

enum PromptOptions {
    static let sections = ["Style", "Mood", "Vocals", "Instruments", "Production", "Effects", "Arrangement", "Advanced"]
    static let genres = ["Dream Pop", "Shoegaze", "Industrial", "Synthwave", "Black Metal", "Death Metal", "Groove Metal", "Country", "Folk", "Ambient", "Dub", "EDM", "Post-Rock"]
    static let keys = ["C major", "A minor", "D minor", "B minor", "F# minor", "E minor"]
    static let timeSignatures = ["4/4", "3/4", "6/8", "5/4", "7/8", "9/8", "11/8"]
    static let moods = ["Longing", "Nostalgia", "Isolation", "Hope", "Grief", "Triumph", "Romance", "Despair", "Catharsis", "Anger", "Wonder", "Melancholy", "Apocalyptic", "Bittersweet"]
    static let vocalTypes = ["Female lead", "Male lead", "Duet", "Choir", "Spoken word", "Instrumental"]
    static let vocalStyles = ["intimate", "whispered", "powerful", "clean", "gritty", "layered harmonies", "vocoder backing vocals", "screams", "growls"]
    static let instruments = ["acoustic guitar", "clean electric guitar", "distorted guitar", "7-string guitar", "overdriven bass guitar", "warm piano", "analog synth pads", "granular synth textures", "wavetable synth", "choir pads", "cinematic strings", "field recordings", "industrial percussion"]
    static let reverbTypes = ["small room", "studio", "plate", "spring", "hall", "cathedral", "gated", "reverse", "infinite"]
    static let delayTypes = ["none", "tape delay", "analog delay", "digital delay", "ping-pong delay", "dub delay"]
    static let saturationTypes = ["clean", "tape warmth", "tube saturation", "console saturation", "overdriven", "destroyed"]
    static let dynamicsTypes = ["intimate", "balanced", "radio polished", "wall of sound", "raw and aggressive"]
    static let effects = ["vinyl crackle", "tape hiss", "radio static", "shortwave interference", "rain ambience", "city ambience", "thunder", "reverse cymbals", "risers", "glitch edits", "stutter effects", "sidechain pumping"]
    static let arrangementSections = ["Intro", "Verse", "Pre-Chorus", "Chorus", "Bridge", "Breakdown", "Instrumental", "Solo", "Final Chorus", "Outro"]
}

extension PromptPreset {
    static let empty = PromptPreset(name: "Untitled Prompt")

    static let starterPresets: [PromptPreset] = [
        PromptPreset(
            name: "Dream Pop Heartbreak",
            genres: ["Dream Pop", "Shoegaze"],
            moods: ["Longing", "Nostalgia", "Bittersweet"],
            bpm: 92,
            key: "B minor",
            timeSignature: "6/8",
            vocalType: "Female lead",
            vocalStyles: ["intimate", "layered harmonies"],
            vocalDistance: 0.2,
            vocalIntensity: 0.62,
            instruments: ["clean electric guitar", "analog synth pads", "granular synth textures", "overdriven bass guitar"],
            reverbType: "cathedral",
            reverbAmount: 0.76,
            delayType: "tape delay",
            saturationType: "tape warmth",
            stereoWidth: 0.78,
            dynamics: "wall of sound",
            effects: ["vinyl crackle", "rain ambience", "reverse cymbals"],
            arrangementSections: ["Intro", "Verse", "Chorus", "Bridge", "Final Chorus", "Outro"],
            customNotes: "Intimate verses should bloom into a cathartic chorus."
        ),
        PromptPreset(
            name: "Blackened Groove Metal",
            genres: ["Black Metal", "Groove Metal", "Industrial"],
            moods: ["Anger", "Catharsis", "Apocalyptic"],
            bpm: 148,
            key: "F# minor",
            timeSignature: "4/4",
            vocalType: "Male lead",
            vocalStyles: ["gritty", "screams", "growls"],
            vocalDistance: 0.48,
            vocalIntensity: 0.9,
            instruments: ["distorted guitar", "7-string guitar", "overdriven bass guitar", "industrial percussion"],
            reverbType: "gated",
            reverbAmount: 0.38,
            delayType: "digital delay",
            saturationType: "overdriven",
            stereoWidth: 0.66,
            dynamics: "raw and aggressive",
            effects: ["glitch edits", "risers"],
            arrangementSections: ["Intro", "Verse", "Chorus", "Breakdown", "Solo", "Final Chorus"]
        ),
        PromptPreset(
            name: "Industrial Dub Night Drive",
            genres: ["Industrial", "Dub", "Synthwave"],
            moods: ["Isolation", "Wonder", "Melancholy"],
            bpm: 104,
            key: "D minor",
            timeSignature: "4/4",
            vocalType: "Spoken word",
            vocalStyles: ["whispered", "vocoder backing vocals"],
            instruments: ["wavetable synth", "industrial percussion", "analog synth pads", "overdriven bass guitar"],
            reverbType: "spring",
            reverbAmount: 0.52,
            delayType: "dub delay",
            saturationType: "console saturation",
            stereoWidth: 0.82,
            dynamics: "balanced",
            effects: ["radio static", "shortwave interference", "sidechain pumping"],
            arrangementSections: ["Intro", "Verse", "Instrumental", "Bridge", "Outro"]
        ),
        PromptPreset(
            name: "Atmospheric Post-Rock Build",
            genres: ["Post-Rock", "Ambient"],
            moods: ["Hope", "Triumph", "Catharsis"],
            bpm: 76,
            key: "E minor",
            timeSignature: "5/4",
            vocalType: "Instrumental",
            instruments: ["clean electric guitar", "cinematic strings", "warm piano", "field recordings"],
            reverbType: "hall",
            reverbAmount: 0.7,
            delayType: "ping-pong delay",
            saturationType: "clean",
            stereoWidth: 0.86,
            dynamics: "wall of sound",
            effects: ["rain ambience", "risers", "reverse cymbals"],
            arrangementSections: ["Intro", "Instrumental", "Bridge", "Breakdown", "Final Chorus", "Outro"],
            detailLevel: .extreme
        ),
        PromptPreset(
            name: "Melancholy Female Vocal",
            genres: ["Folk", "Dream Pop"],
            moods: ["Melancholy", "Romance", "Grief"],
            bpm: 68,
            key: "A minor",
            vocalType: "Female lead",
            vocalStyles: ["intimate", "clean", "layered harmonies"],
            vocalDistance: 0.12,
            vocalIntensity: 0.36,
            instruments: ["acoustic guitar", "warm piano", "cinematic strings"],
            reverbType: "plate",
            reverbAmount: 0.42,
            delayType: "analog delay",
            saturationType: "tape warmth",
            stereoWidth: 0.48,
            dynamics: "intimate",
            effects: ["tape hiss"],
            arrangementSections: ["Intro", "Verse", "Pre-Chorus", "Chorus", "Outro"]
        ),
        PromptPreset(
            name: "Apocalyptic Choir Metal",
            genres: ["Death Metal", "Black Metal", "Ambient"],
            moods: ["Apocalyptic", "Despair", "Wonder"],
            bpm: 132,
            key: "F# minor",
            timeSignature: "7/8",
            vocalType: "Choir",
            vocalStyles: ["powerful", "layered harmonies", "growls"],
            instruments: ["distorted guitar", "7-string guitar", "choir pads", "cinematic strings", "industrial percussion"],
            reverbType: "cathedral",
            reverbAmount: 0.84,
            delayType: "none",
            saturationType: "tube saturation",
            stereoWidth: 0.74,
            dynamics: "raw and aggressive",
            effects: ["thunder", "risers", "reverse cymbals"],
            arrangementSections: ["Intro", "Verse", "Chorus", "Breakdown", "Final Chorus", "Outro"],
            detailLevel: .extreme
        )
    ]
}

import Foundation

struct PromptPreset: Identifiable, Codable, Equatable {
    var id: UUID
    var name: String
    var genres: [String]
    var moods: [String]
    var bpm: Double
    var key: String
    var mode: String
    var timeSignature: String
    var alternateTimeSignatures: [String]
    var tempoFeel: String
    var tempoMap: String
    var swingAmount: Double
    var tempoHumanization: Double
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
        key: String = "B",
        mode: String = "Aeolian / natural minor",
        timeSignature: String = "4/4",
        alternateTimeSignatures: [String] = [],
        tempoFeel: String = "straight",
        tempoMap: String = "steady tempo",
        swingAmount: Double = 0,
        tempoHumanization: Double = 0.12,
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
        self.mode = mode
        self.timeSignature = timeSignature
        self.alternateTimeSignatures = alternateTimeSignatures
        self.tempoFeel = tempoFeel
        self.tempoMap = tempoMap
        self.swingAmount = swingAmount
        self.tempoHumanization = tempoHumanization
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
        case mode
        case timeSignature
        case alternateTimeSignatures
        case tempoFeel
        case tempoMap
        case swingAmount
        case tempoHumanization
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
        let decodedKey = try container.decodeIfPresent(String.self, forKey: .key) ?? "B"
        let decodedMode = try container.decodeIfPresent(String.self, forKey: .mode)
        let normalized = PromptPreset.normalizedKeyAndMode(key: decodedKey, mode: decodedMode)
        key = normalized.key
        mode = normalized.mode
        timeSignature = try container.decodeIfPresent(String.self, forKey: .timeSignature) ?? "4/4"
        alternateTimeSignatures = try container.decodeIfPresent([String].self, forKey: .alternateTimeSignatures) ?? []
        tempoFeel = try container.decodeIfPresent(String.self, forKey: .tempoFeel) ?? "straight"
        tempoMap = try container.decodeIfPresent(String.self, forKey: .tempoMap) ?? "steady tempo"
        swingAmount = try container.decodeIfPresent(Double.self, forKey: .swingAmount) ?? 0
        tempoHumanization = try container.decodeIfPresent(Double.self, forKey: .tempoHumanization) ?? 0.12
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

private extension PromptPreset {
    static func normalizedKeyAndMode(key: String, mode: String?) -> (key: String, mode: String) {
        let trimmedKey = key.trimmingCharacters(in: .whitespacesAndNewlines)
        if let mode, !mode.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return (trimmedKey, mode)
        }

        let lowercased = trimmedKey.lowercased()
        if lowercased.hasSuffix(" major") {
            return (String(trimmedKey.dropLast(6)), "Ionian / major")
        }
        if lowercased.hasSuffix(" minor") {
            return (String(trimmedKey.dropLast(6)), "Aeolian / natural minor")
        }
        return (trimmedKey.isEmpty ? "C" : trimmedKey, "Ionian / major")
    }
}

enum PromptDetailLevel: String, CaseIterable, Identifiable, Codable {
    case simple = "Simple"
    case detailed = "Detailed"
    case extreme = "Extreme"

    var id: String { rawValue }
}

enum PromptOptions {
    static let sections = ["Style", "Advanced Time", "Mood", "Vocals", "Instruments", "Production", "Effects", "Arrangement", "Advanced"]
    static let contemporaryGenres = [
        "Dream Pop", "Shoegaze", "Industrial", "Synthwave", "Black Metal", "Death Metal", "Groove Metal", "Country", "Folk", "Ambient", "Dub", "EDM", "Post-Rock",
        "Alternative Rock", "Indie Rock", "Garage Rock", "Noise Rock", "Math Rock", "Art Rock", "Goth Rock", "Post-Punk", "Darkwave", "Coldwave", "New Wave", "No Wave", "Psychedelic Rock", "Stoner Rock", "Desert Rock", "Krautrock", "Progressive Rock", "Space Rock",
        "Doom Metal", "Sludge Metal", "Stoner Metal", "Post-Metal", "Atmospheric Black Metal", "Blackgaze", "Melodic Death Metal", "Technical Death Metal", "Brutal Death Metal", "Funeral Doom", "Symphonic Metal", "Power Metal", "Thrash Metal", "Speed Metal", "Metalcore", "Deathcore", "Djent", "Grindcore", "Crust Punk",
        "Punk Rock", "Hardcore Punk", "Post-Hardcore", "Emo", "Midwest Emo", "Screamo", "Pop Punk", "Skate Punk", "Riot Grrrl",
        "Pop", "Indie Pop", "Synthpop", "Electropop", "Hyperpop", "Bubblegum Bass", "Art Pop", "Baroque Pop", "Chamber Pop", "Bedroom Pop", "Jangle Pop", "Power Pop", "K-Pop", "J-Pop", "City Pop",
        "R&B", "Alternative R&B", "Neo-Soul", "Soul", "Funk", "Disco", "Nu-Disco", "Boogie", "Quiet Storm", "Gospel", "Contemporary Gospel",
        "Hip-Hop", "Boom Bap", "Trap", "Drill", "Cloud Rap", "Abstract Hip-Hop", "Jazz Rap", "Lo-Fi Hip-Hop", "Phonk", "Memphis Rap", "Grime", "UK Garage Rap",
        "House", "Deep House", "Acid House", "Progressive House", "Tech House", "French House", "Garage House", "Tribal House", "Amapiano House", "Techno", "Detroit Techno", "Minimal Techno", "Dub Techno", "Acid Techno", "Industrial Techno", "Hard Techno", "Trance", "Goa Trance", "Psytrance", "Progressive Trance",
        "Drum and Bass", "Jungle", "Liquid Drum and Bass", "Neurofunk", "Breakcore", "IDM", "Glitch", "Glitch Hop", "Downtempo", "Trip-Hop", "Future Garage", "UK Garage", "2-Step", "Dubstep", "Post-Dubstep", "Brostep", "Trap EDM", "Footwork", "Juke", "Jersey Club", "Baltimore Club", "Breakbeat", "Big Beat", "Electro", "Electroclash",
        "Ambient Techno", "Drone", "Dark Ambient", "Space Ambient", "New Age", "Minimalism", "Modern Classical", "Neoclassical", "Cinematic", "Trailer Music", "Soundscape", "Musique Concrete", "Electroacoustic", "Noise", "Harsh Noise", "Power Electronics", "Vaporwave", "Mallsoft", "Chillwave", "Witch House",
        "Jazz", "Bebop", "Hard Bop", "Cool Jazz", "Modal Jazz", "Free Jazz", "Spiritual Jazz", "Jazz Fusion", "Acid Jazz", "Nu Jazz", "Swing", "Big Band", "Ragtime",
        "Blues", "Electric Blues", "Chicago Blues", "Texas Blues", "Swamp Blues", "Rockabilly", "Americana", "Alt-Country", "Outlaw Country", "Bluegrass Gospel", "Singer-Songwriter",
        "Reggae Fusion", "Dub Poetry", "Lovers Rock", "Latin Pop", "Latin Rock", "Tropical House", "Moombahton"
    ]
    static let ethnicMusicStyles = [
        "Afrobeat", "Afrobeats", "Highlife", "Juju", "Fuji", "Apala", "Sakara", "Igbo highlife", "Palm-wine music", "Soukous", "Rumba Congolaise", "Makossa", "Bikutsi", "Mbalax", "Gnawa", "Griot kora music", "Wassoulou", "Mandinka praise song", "Tuareg desert blues", "Tishoumaren", "Ethiopian jazz", "Ethio traditional", "Tigrinya music", "Somali dhaanto", "Sudanese aghani", "Nubian music", "Taarab", "Benga", "Genge", "Kwaito", "Amapiano", "Mbaqanga", "Maskandi", "Isicathamiya", "Mbube", "Shona mbira", "Chimurenga", "Marrabenta", "Sega", "Maloya", "Salegy", "Hira gasy", "Morna", "Coladeira", "Funana",
        "Arabic maqam", "Tarab", "Khaliji", "Dabke", "Levantine folk", "Iraqi maqam", "Andalusian classical", "Chaabi", "Rai", "Malhun", "Berber Amazigh music", "Coptic chant", "Mizrahi", "Piyyut", "Klezmer", "Persian dastgah", "Radif", "Kurdish folk", "Turkish makam", "Turkish fasil", "Anatolian folk", "Sufi qawwali", "Sufi sama", "Ottoman classical", "Armenian duduk music", "Georgian polyphony", "Azeri mugham",
        "Hindustani classical", "Carnatic classical", "Raga alap", "Dhrupad", "Khyal", "Thumri", "Ghazal", "Bhajan", "Kirtan", "Qawwali", "Bhangra", "Giddha", "Lavani", "Baul", "Rabindra sangeet", "Sufi folk", "Rajasthani folk", "Garba", "Dandiya raas", "Bhojpuri folk", "Assamese Bihu", "Kashmiri sufiana", "Nepali lok dohori", "Tibetan chant", "Bhutanese zhungdra", "Sinhala baila", "Sri Lankan folk", "Maldivian boduberu",
        "Chinese guoyue", "Chinese opera", "Peking opera", "Cantonese opera", "Jiangnan sizhu", "Nanguan", "Hakka mountain songs", "Mongolian long song", "Tuvan throat singing", "Khoomei", "Uyghur muqam", "Tibetan folk", "Korean pansori", "Korean samulnori", "Korean gugak", "Japanese gagaku", "Japanese minyo", "Shakuhachi honkyoku", "Taiko", "Okinawan minyo", "Ainu upopo", "Vietnamese ca tru", "Vietnamese quan ho", "Vietnamese dan ca", "Thai luk thung", "Thai mor lam", "Thai piphat", "Lao lam", "Cambodian pinpeat", "Khmer folk", "Burmese hsaing waing", "Indonesian gamelan", "Balinese gamelan", "Javanese gamelan", "Sundanese degung", "Kroncong", "Dangdut", "Malay asli", "Dikir barat", "Filipino kundiman", "Kulintang", "Rondalla",
        "Flamenco", "Fado", "Sephardic song", "Celtic folk", "Irish sean-nos", "Scottish pibroch", "Welsh folk", "Breton fest-noz", "Galician folk", "Basque trikitixa", "Nordic folk", "Swedish polska", "Norwegian hardanger fiddle", "Finnish runo song", "Karelian folk", "Sami joik", "Baltic daina", "Estonian regilaul", "Balkan brass", "Sevdalinka", "Serbian kolo", "Bulgarian folk choir", "Macedonian oro", "Greek rebetiko", "Greek laiko", "Cretan lyra", "Albanian iso-polyphony", "Romanian doina", "Hungarian csardas", "Roma brass", "Russian bylina", "Ukrainian dumka", "Polish mazurka", "Polish polonaise",
        "Andean huayno", "Andean sikuri", "Peruvian criollo", "Marinera", "Cumbia", "Vallenato", "Champeta", "Joropo", "Merengue tipico", "Bachata", "Son cubano", "Rumba cubana", "Guaguanco", "Mambo", "Cha-cha-cha", "Bolero", "Nueva trova", "Reggaeton", "Dancehall", "Ska", "Rocksteady", "Roots reggae", "Calypso", "Soca", "Steelpan", "Zouk", "Kompa", "Gwo ka", "Bomba", "Plena", "Mariachi", "Ranchera", "Norteno", "Banda sinaloense", "Son jarocho", "Huapango", "Corridos", "Tejano", "Choro", "Samba", "Bossa nova", "Forro", "Baiao", "Maracatu", "Frevo", "Axe", "Capoeira music", "Tango", "Milonga", "Cueca", "Nueva cancion", "Mapuche music",
        "Chicha", "Cumbia sonidera", "Cumbia villera", "Tecnocumbia", "Porro", "Gaita colombiana", "Bullerenge", "Currulao", "Tamborito", "Punto cubano", "Trova yucateca", "Nueva cancion chilena", "Murga uruguaya", "Candombe", "Chamame", "Zamba argentina", "Gato argentino", "Saya afro-boliviana", "Morenada", "Caporales", "Cueca boliviana", "Pasillo", "Sanjuanito", "Albazo", "Bullerengue", "Garifuna punta", "Garifuna paranda", "Belize brukdown",
        "Native American powwow", "Plains flute music", "Inuit throat singing", "Metis fiddle", "Appalachian old-time", "Bluegrass", "Cajun", "Zydeco", "Gospel spirituals", "Delta blues", "Piedmont blues", "New Orleans second line",
        "Navajo chant", "Hopi ceremonial song", "Haudenosaunee social dance song", "Ojibwe hand drum song", "Cree round dance", "Lakota honor song", "Pueblo buffalo dance song",
        "Australian Aboriginal songlines", "Didgeridoo ceremonial", "Torres Strait Islander music", "Maori waiata", "Haka", "Samoan pese", "Tongan lakalaka", "Fijian meke", "Hawaiian mele", "Hula kahiko", "Tahitian himene", "Micronesian chant", "Melanesian bamboo band",
        "Papuan string band", "Vanuatu water music", "Solomon Islands panpipe", "Kaneka", "Chamorro chant", "Kiribati ruoia", "Cook Islands ute", "Rapa Nui chant",
        "Tarantella", "Pizzica", "Sardinian canto a tenore", "Corsican polyphony", "Occitan folk", "Swiss alphorn music", "Austrian schrammelmusik", "Bavarian oompah", "Czech polka", "Slovak fujara music", "Slovenian folk", "Croatian klapa", "Dalmatian folk", "Montenegrin gusle", "Turkish Roman music",
        "Buryat folk", "Yakut khomus music", "Kazakh kuy", "Kyrgyz komuz music", "Uzbek shashmaqam", "Tajik falak", "Pashto folk", "Balochi folk", "Sindhi sufiana kalam", "Punjabi tappay", "Tamil gaana", "Malayalam sopana sangeetham", "Manipuri pena music", "Naga folk", "Mizo folk",
        "Hmong qeej music", "Thai khim music", "Isan kantrum", "Balinese kecak", "Sasak gendang beleq", "Batak gondang", "Minangkabau talempong", "Acehnese saman", "Dayak sape music", "Borneo nose flute", "Timorese tebe", "Boduberu fusion"
    ]
    static let genres = contemporaryGenres + ethnicMusicStyles
    static let keys = ["C", "C# / Db", "D", "D# / Eb", "E", "F", "F# / Gb", "G", "G# / Ab", "A", "A# / Bb", "B"]
    static let modes = [
        "Ionian / major",
        "Dorian",
        "Phrygian",
        "Lydian",
        "Mixolydian",
        "Aeolian / natural minor",
        "Locrian",
        "Harmonic minor",
        "Melodic minor",
        "Phrygian dominant",
        "Lydian dominant",
        "Dorian b2",
        "Lydian augmented",
        "Mixolydian b6",
        "Locrian natural 2",
        "Altered / super Locrian",
        "Major pentatonic",
        "Minor pentatonic",
        "Blues scale",
        "Whole tone",
        "Diminished / octatonic",
        "Chromatic"
    ]
    static let timeSignatures = ["2/4", "3/4", "4/4", "5/4", "6/4", "7/4", "2/2", "3/8", "5/8", "6/8", "7/8", "9/8", "11/8", "12/8", "13/8", "15/8", "3+2/8", "2+3/8", "2+2+3/8", "3+2+2/8", "4+3/8", "5+4/8", "7+4/8", "17/16"]
    static let tempoFeels = ["straight", "laid-back", "pushing forward", "behind the beat", "driving", "floating", "mechanical", "loose live band", "rubato", "half-time feel", "double-time feel", "four-on-the-floor", "breakbeat", "shuffle", "triplet feel"]
    static let tempoMaps = ["steady tempo", "subtle tempo drift", "gradual accelerando", "gradual ritardando", "verse slower than chorus", "chorus lifts by 4 BPM", "breakdown drops to half-time", "final chorus pushes faster", "free-time intro into locked groove"]
    static let moods = ["Longing", "Nostalgia", "Isolation", "Hope", "Grief", "Triumph", "Romance", "Despair", "Catharsis", "Anger", "Wonder", "Melancholy", "Apocalyptic", "Bittersweet"]
    static let vocalTypes = ["Female lead", "Male lead", "Duet", "Choir", "Spoken word", "Instrumental"]
    static let vocalStyles = ["intimate", "whispered", "powerful", "clean", "gritty", "layered harmonies", "vocoder backing vocals", "screams", "growls"]
    static let instruments = ["acoustic guitar", "clean electric guitar", "distorted guitar", "7-string guitar", "overdriven bass guitar", "warm piano", "analog synth pads", "granular synth textures", "wavetable synth", "choir pads", "cinematic strings", "field recordings", "industrial percussion", "kora", "oud", "saz", "duduk", "sitar", "sarod", "tabla", "mridangam", "bansuri", "erhu", "guzheng", "shakuhachi", "taiko drums", "gamelan metallophones", "kulintang gongs", "mbira", "balafon", "djembe", "talking drum", "berimbau", "bandoneon", "pan flute", "charango", "bagpipes", "bodhran", "hardanger fiddle", "didgeridoo", "frame drums"]
    static let reverbTypes = ["small room", "studio", "plate", "spring", "hall", "cathedral", "gated", "reverse", "infinite"]
    static let delayTypes = ["none", "tape delay", "analog delay", "digital delay", "ping-pong delay", "dub delay"]
    static let saturationTypes = ["clean", "tape warmth", "tube saturation", "console saturation", "overdriven", "destroyed"]
    static let dynamicsTypes = ["intimate", "balanced", "radio polished", "wall of sound", "raw and aggressive"]
    static let effects = ["vinyl crackle", "tape hiss", "radio static", "shortwave interference", "rain ambience", "city ambience", "thunder", "reverse cymbals", "risers", "glitch edits", "stutter effects", "sidechain pumping"]
    static let arrangementSections = ["Intro", "Verse", "Pre-Chorus", "Chorus", "Bridge", "Breakdown", "Instrumental", "Solo", "Final Chorus", "Outro"]
}

extension PromptPreset {
    static let empty = PromptPreset(name: "Untitled Prompt")

    static let starterPresets: [PromptPreset] = coreStarterPresets + hybridStarterPresets

    private static let coreStarterPresets: [PromptPreset] = [
        PromptPreset(
            name: "Dream Pop Heartbreak",
            genres: ["Dream Pop", "Shoegaze"],
            moods: ["Longing", "Nostalgia", "Bittersweet"],
            bpm: 92,
            key: "B",
            mode: "Aeolian / natural minor",
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
            key: "F# / Gb",
            mode: "Phrygian dominant",
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
            key: "D",
            mode: "Dorian",
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
            key: "E",
            mode: "Aeolian / natural minor",
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
            key: "A",
            mode: "Aeolian / natural minor",
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
            key: "F# / Gb",
            mode: "Locrian",
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

    private static let hybridStarterPresets: [PromptPreset] = [
        hybridPreset("Cathedral Black Metal", ["Cathedral Black Metal", "Atmospheric Black Metal", "Sacred Choral"], ["Apocalyptic", "Catharsis", "Sacred"], bpm: 126, key: "F# / Gb", mode: "Phrygian dominant", vocalType: "Choir"),
        hybridPreset("Dream Pop Deathcore", ["Dream Pop Deathcore", "Dream Pop", "Deathcore"], ["Longing", "Catharsis", "Dreamlike"], bpm: 142, key: "B", mode: "Aeolian / natural minor", vocalType: "Duet"),
        hybridPreset("Industrial Dub Shoegaze", ["Industrial Dub Shoegaze", "Industrial Dub", "Shoegaze"], ["Urban", "Isolated", "Nostalgic"], bpm: 104, key: "D", mode: "Dorian", vocalType: "Spoken word"),
        hybridPreset("Appalachian Doom", ["Appalachian Doom", "Appalachian Folk", "Traditional Doom"], ["Rural", "Haunted", "Melancholic"], bpm: 68, key: "A", mode: "Aeolian / natural minor", vocalType: "Male lead"),
        hybridPreset("Cyberpunk Gospel", ["Cyberpunk Gospel", "Gospel", "Cyberpunk Score"], ["Spiritual", "Futuristic", "Triumphant"], bpm: 118, key: "C# / Db", mode: "Mixolydian", vocalType: "Choir"),
        hybridPreset("Viking Synthwave", ["Viking Synthwave", "Synthwave", "Viking Metal"], ["Heroic", "Cosmic", "Triumphant"], bpm: 112, key: "E", mode: "Dorian", vocalType: "Male lead"),
        hybridPreset("Ritual Ambient Techno", ["Ritual Ambient Techno", "Ritual Ambient", "Hypnotic Techno"], ["Mystical", "Spiritual", "Night-Time"], bpm: 124, key: "G", mode: "Phrygian", vocalType: "Instrumental"),
        hybridPreset("Blackened Trip Hop", ["Blackened Trip Hop", "Trip-Hop", "Black Metal"], ["Dystopian", "Lonely", "Haunted"], bpm: 82, key: "D# / Eb", mode: "Locrian", vocalType: "Female lead"),
        hybridPreset("Desert Psychedelic Doom", ["Desert Psychedelic Doom", "Psychedelic Doom", "Desert Rock"], ["Apocalyptic", "Rural", "Cosmic"], bpm: 72, key: "F", mode: "Phrygian dominant", vocalType: "Male lead"),
        hybridPreset("Space Western", ["Space Western", "Space Rock", "Country Rock"], ["Cosmic", "Lonely", "Heroic"], bpm: 96, key: "G", mode: "Mixolydian", vocalType: "Male lead"),
        hybridPreset("Monastic Industrial", ["Monastic Industrial", "Monastic Chant", "Industrial Ambient"], ["Sacred", "Dystopian", "Isolated"], bpm: 88, key: "C", mode: "Phrygian", vocalType: "Choir"),
        hybridPreset("Post-Apocalyptic Folk", ["Post-Apocalyptic Folk", "Dark Folk", "Post-Apocalyptic Score"], ["Apocalyptic", "Hopeful", "Rural"], bpm: 78, key: "E", mode: "Aeolian / natural minor", vocalType: "Female lead"),
        hybridPreset("Gothic Americana", ["Gothic Americana", "Americana", "Gothic Rock"], ["Haunted", "Romantic", "Melancholic"], bpm: 84, key: "A", mode: "Dorian", vocalType: "Duet"),
        hybridPreset("Dark Jazz Noir", ["Dark Jazz Noir", "Modal Jazz", "Dark Cinematic"], ["Night-Time", "Urban", "Mystical"], bpm: 74, key: "D", mode: "Dorian", vocalType: "Spoken word"),
        hybridPreset("Haunted Carnival", ["Haunted Carnival", "Dark Cabaret", "Horror Soundtrack"], ["Haunted", "Dreamlike", "Dystopian"], bpm: 132, key: "A# / Bb", mode: "Harmonic minor", vocalType: "Choir"),
        hybridPreset("Soviet Space Ambient", ["Soviet Space Ambient", "Space Ambient", "Military Documentary"], ["Cosmic", "Isolated", "Nostalgic"], bpm: 62, key: "C", mode: "Lydian", vocalType: "Instrumental"),
        hybridPreset("Nuclear Winter Soundtrack", ["Nuclear Winter Soundtrack", "Dark Ambient", "Post-Apocalyptic Score"], ["Winter", "Apocalyptic", "Lonely"], bpm: 58, key: "F# / Gb", mode: "Locrian", vocalType: "Instrumental"),
        hybridPreset("Cosmic Funeral Doom", ["Cosmic Funeral Doom", "Funeral Doom", "Space Ambient"], ["Cosmic", "Grief", "Sacred"], bpm: 48, key: "B", mode: "Locrian", vocalType: "Choir"),
        hybridPreset("Medieval Cyberpunk", ["Medieval Cyberpunk", "Medieval Folk", "Cyberpunk Score"], ["Futuristic", "Mystical", "Urban"], bpm: 110, key: "D", mode: "Dorian", vocalType: "Female lead"),
        hybridPreset("Deep Ocean Drone", ["Deep Ocean Drone", "Drone Ambient", "Oceanic"], ["Oceanic", "Isolated", "Mystical"], bpm: 44, key: "C# / Db", mode: "Whole tone", vocalType: "Instrumental"),
        hybridPreset("Urban Isolation Soundscape", ["Urban Isolation Soundscape", "Soundscape", "Dark Ambient"], ["Urban", "Isolated", "Lonely"], bpm: 70, key: "G# / Ab", mode: "Aeolian / natural minor", vocalType: "Spoken word"),
        hybridPreset("Drone Pilot Night Flight", ["Drone Pilot Night Flight", "Ambient Techno", "Dark Cinematic"], ["Night-Time", "Futuristic", "Isolated"], bpm: 102, key: "E", mode: "Dorian", vocalType: "Instrumental"),
        hybridPreset("Rainy Suburban Nostalgia", ["Rainy Suburban Nostalgia", "Dream Pop", "Lo-Fi"], ["Nostalgic", "Longing", "Rainy"], bpm: 86, key: "A", mode: "Ionian / major", vocalType: "Female lead"),
        hybridPreset("Forgotten Shopping Mall Vaporwave", ["Forgotten Shopping Mall Vaporwave", "Mallsoft", "Vaporwave"], ["Nostalgic", "Haunted", "Dreamlike"], bpm: 76, key: "F", mode: "Lydian", vocalType: "Instrumental"),
        hybridPreset("Last Train Home", ["Last Train Home", "Post-Rock Cinematic", "Ambient Pop"], ["Longing", "Night-Time", "Hopeful"], bpm: 92, key: "E", mode: "Mixolydian", vocalType: "Female lead"),
        hybridPreset("Cold War Numbers Station", ["Cold War Numbers Station", "Industrial Ambient", "Radio Broadcast"], ["Dystopian", "Haunted", "Night-Time"], bpm: 66, key: "D", mode: "Phrygian", vocalType: "Spoken word"),
        hybridPreset("Arctic Research Station Ambient", ["Arctic Research Station Ambient", "Isolationist Ambient", "Cinematic Ambient"], ["Winter", "Isolated", "Cosmic"], bpm: 52, key: "C", mode: "Lydian", vocalType: "Instrumental"),
        hybridPreset("Abandoned Cathedral Choir", ["Abandoned Cathedral Choir", "Sacred Choral", "Dark Ambient"], ["Sacred", "Haunted", "Grief"], bpm: 60, key: "G", mode: "Aeolian / natural minor", vocalType: "Choir"),
        hybridPreset("Industrial Pop Noir", ["Industrial Pop Noir", "Industrial Pop", "Noir Pop"], ["Night-Time", "Urban", "Melancholic"], bpm: 104, key: "D", mode: "Dorian", vocalType: "Female lead"),
        hybridPreset("Gothic Synth Pop", ["Gothic Synth Pop", "Gothic Pop", "Synth Pop"], ["Romantic", "Haunted", "Nostalgic"], bpm: 112, key: "A", mode: "Aeolian / natural minor", vocalType: "Duet"),
        hybridPreset("Cathedral Pop", ["Cathedral Pop", "Orchestral Pop", "Sacred Choral"], ["Sacred", "Ethereal", "Triumphant"], bpm: 92, key: "C", mode: "Ionian / major", vocalType: "Choir"),
        hybridPreset("Hyperpop Meltdown", ["Hyperpop Meltdown", "Hyperpop", "Glitch Pop"], ["Cathartic", "Futuristic", "Apocalyptic"], bpm: 168, key: "F# / Gb", mode: "Lydian", vocalType: "Female lead"),
        hybridPreset("Nordic Winter Pop", ["Nordic Winter Pop", "Nordic Pop", "Winter Pop"], ["Winter", "Longing", "Ethereal"], bpm: 86, key: "E", mode: "Aeolian / natural minor", vocalType: "Female lead"),
        hybridPreset("Analog Nostalgia Pop", ["Analog Nostalgia Pop", "Vintage Tape", "Nostalgic Pop"], ["Nostalgic", "Warm", "Bittersweet"], bpm: 94, key: "G", mode: "Ionian / major", vocalType: "Male lead"),
        hybridPreset("Oceanic Dream Pop", ["Oceanic Dream Pop", "Dream Pop", "Oceanic Pop"], ["Oceanic", "Dreamlike", "Longing"], bpm: 88, key: "D", mode: "Lydian", vocalType: "Female lead"),
        hybridPreset("Japanese City Pop Revival", ["Japanese City Pop Revival", "City Pop", "J-Pop"], ["Night-Time", "Urban", "Nostalgic"], bpm: 108, key: "A", mode: "Mixolydian", vocalType: "Female lead"),
        hybridPreset("Haunted Mall Pop", ["Haunted Mall Pop", "Mallsoft", "Dark Pop"], ["Haunted", "Nostalgic", "Lonely"], bpm: 78, key: "F", mode: "Lydian", vocalType: "Instrumental"),
        hybridPreset("Late-Night Radio Pop", ["Late-Night Radio Pop", "Radio Pop", "Warm Cassette Pop"], ["Night-Time", "Romantic", "Reflective"], bpm: 82, key: "B", mode: "Aeolian / natural minor", vocalType: "Male lead"),
        hybridPreset("Cathedral Shoegaze", ["Cathedral Shoegaze", "Shoegaze", "Cathedral Gothic Rock"], ["Sacred", "Ethereal", "Longing"], bpm: 92, key: "B", mode: "Aeolian / natural minor", vocalType: "Female lead"),
        hybridPreset("Industrial Post-Rock", ["Industrial Post-Rock", "Post-Rock", "Industrial Rock"], ["Dystopian", "Cinematic", "Urban"], bpm: 96, key: "D", mode: "Dorian", vocalType: "Instrumental"),
        hybridPreset("Atmospheric Alternative Rock", ["Atmospheric Alternative Rock", "Alternative Rock", "Cinematic Rock"], ["Nostalgic", "Hopeful", "Melancholic"], bpm: 104, key: "G", mode: "Mixolydian", vocalType: "Male lead"),
        hybridPreset("Nordic Winter Rock", ["Nordic Winter Rock", "Nordic Rock", "Winter Rock"], ["Winter", "Longing", "Heroic"], bpm: 88, key: "E", mode: "Aeolian / natural minor", vocalType: "Duet"),
        hybridPreset("Desert Highway Rock", ["Desert Highway Rock", "Desert Rock", "Americana Rock"], ["Rural", "Nocturnal", "Longing"], bpm: 110, key: "A", mode: "Dorian", vocalType: "Male lead"),
        hybridPreset("Rainy Night Indie Rock", ["Rainy Night Indie Rock", "Indie Rock", "Rainy-Day Rock"], ["Night-Time", "Nostalgic", "Lonely"], bpm: 86, key: "C", mode: "Ionian / major", vocalType: "Female lead"),
        hybridPreset("Cosmic Space Rock", ["Cosmic Space Rock", "Space Rock", "Cosmic Rock"], ["Cosmic", "Dreamlike", "Triumphant"], bpm: 118, key: "F# / Gb", mode: "Lydian", vocalType: "Instrumental"),
        hybridPreset("Apocalyptic Arena Rock", ["Apocalyptic Arena Rock", "Arena Rock", "Apocalyptic Rock"], ["Apocalyptic", "Heroic", "Triumphant"], bpm: 128, key: "D", mode: "Phrygian dominant", vocalType: "Male lead"),
        hybridPreset("Cinematic Slowcore", ["Cinematic Slowcore", "Slowcore", "Cinematic Rock"], ["Melancholic", "Longing", "Reflective"], bpm: 64, key: "A", mode: "Aeolian / natural minor", vocalType: "Female lead"),
        hybridPreset("Forgotten City Indie Rock", ["Forgotten City Indie Rock", "Indie Rock", "Urban Rock"], ["Urban", "Haunted", "Nostalgic"], bpm: 98, key: "E", mode: "Dorian", vocalType: "Male lead")
    ]

    private static func hybridPreset(_ name: String, _ genres: [String], _ moods: [String], bpm: Double, key: String, mode: String, vocalType: String) -> PromptPreset {
        PromptPreset(
            name: name,
            genres: genres,
            moods: moods,
            bpm: bpm,
            key: key,
            mode: mode,
            timeSignature: "4/4",
            tempoFeel: "loose live band",
            tempoMap: "subtle tempo drift",
            swingAmount: 0.18,
            tempoHumanization: 0.32,
            vocalType: vocalType,
            vocalStyles: vocalType == "Instrumental" ? [] : ["layered harmonies"],
            vocalDistance: 0.62,
            vocalIntensity: 0.68,
            instruments: ["analog synth pads", "field recordings", "cinematic strings", "industrial percussion"],
            reverbType: "cathedral",
            reverbAmount: 0.78,
            delayType: "tape delay",
            saturationType: "tape warmth",
            stereoWidth: 0.82,
            dynamics: "wall of sound",
            effects: ["tape hiss", "radio static", "reverse cymbals"],
            arrangementSections: ["Intro", "Verse", "Chorus", "Bridge", "Final Chorus", "Outro"],
            detailLevel: .extreme,
            frontLoadEnabled: true,
            frontLoadText: "\(name) identity first, make the hybrid style unmistakable immediately",
            artistNameSafeMode: true
        )
    }
}

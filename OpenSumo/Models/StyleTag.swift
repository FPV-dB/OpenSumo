import Foundation

struct StyleTag: Identifiable, Hashable, Sendable {
    var category: String
    var name: String
    var id: String { "\(category)::\(name)" }
}

enum StyleTagCatalog {
    static var categories: [(String, [String])] {
        curatedCategories + [
            ("Contemporary Expanded", PromptOptions.contemporaryGenres),
            ("World Expanded", PromptOptions.ethnicMusicStyles)
        ]
    }

    private static let curatedCategories: [(String, [String])] = [
        ("Rock", ["Classic Rock", "Hard Rock", "Arena Rock", "Blues Rock", "Southern Rock", "Garage Rock", "Alternative Rock", "Indie Rock", "Post-Rock", "Math Rock", "Noise Rock", "Psychedelic Rock", "Progressive Rock", "Art Rock", "Folk Rock", "Gothic Rock", "Surf Rock", "Stoner Rock", "Desert Rock", "Space Rock", "Shoegaze", "Dream Pop", "Britpop", "Grunge", "College Rock"]),
        ("Metal", ["Heavy Metal", "Traditional Metal", "Power Metal", "Speed Metal", "Thrash Metal", "Death Metal", "Melodic Death Metal", "Technical Death Metal", "Brutal Death Metal", "Black Metal", "Atmospheric Black Metal", "Symphonic Black Metal", "Depressive Suicidal Black Metal", "Blackgaze", "Doom Metal", "Funeral Doom", "Epic Doom", "Death Doom", "Gothic Doom", "Sludge Metal", "Groove Metal", "Metalcore", "Deathcore", "Progressive Metal", "Djent", "Symphonic Metal", "Folk Metal", "Viking Metal", "Industrial Metal", "Nu Metal", "Post-Metal", "Avant-Garde Metal", "War Metal"]),
        ("Punk", ["Punk Rock", "Hardcore Punk", "Melodic Hardcore", "Post-Hardcore", "Pop Punk", "Skate Punk", "Crust Punk", "D-Beat", "Anarcho Punk", "Street Punk", "Oi!", "Horror Punk", "Folk Punk", "Celtic Punk"]),
        ("Electronic", ["Ambient", "Dark Ambient", "Drone", "IDM", "Glitch", "Experimental Electronic", "Downtempo", "Chillout", "Trip-Hop", "Breakbeat", "Big Beat", "Electronica", "Electro", "Electroclash", "Synthwave", "Darkwave", "Coldwave", "Retrowave", "Vaporwave", "Future Bass", "Drum & Bass", "Jungle", "Liquid DnB", "Neurofunk", "Dubstep", "Brostep", "UK Garage", "2-Step", "House", "Deep House", "Progressive House", "Tech House", "Minimal House", "Acid House", "Trance", "Progressive Trance", "Psytrance", "Goa Trance", "Hard Trance", "Techno", "Minimal Techno", "Detroit Techno", "Industrial Techno", "Hardstyle", "Hardcore Techno", "Gabber", "Happy Hardcore"]),
        ("Industrial", ["Industrial", "Industrial Rock", "Industrial Metal", "EBM", "Aggrotech", "Electro-Industrial", "Power Noise", "Rhythmic Noise", "Dark Electro", "Industrial Ambient", "Industrial Dub", "Martial Industrial"]),
        ("Pop", ["Pop", "Synth Pop", "Electro Pop", "Dream Pop", "Indie Pop", "Art Pop", "Chamber Pop", "Dance Pop", "Hyperpop", "Bubblegum Pop", "Teen Pop", "Power Pop", "Contemporary Pop"]),
        ("Hip Hop", ["Old School Hip Hop", "Boom Bap", "Conscious Hip Hop", "Alternative Hip Hop", "Jazz Rap", "Gangsta Rap", "Trap", "Drill", "Cloud Rap", "Lo-Fi Hip Hop", "Experimental Hip Hop", "Horrorcore"]),
        ("Soul / R&B", ["Soul", "Neo Soul", "Motown", "Funk", "Contemporary R&B", "Quiet Storm", "Smooth Soul", "Gospel"]),
        ("Jazz", ["Traditional Jazz", "Swing", "Big Band", "Bebop", "Hard Bop", "Cool Jazz", "Modal Jazz", "Free Jazz", "Fusion", "Jazz-Funk", "Smooth Jazz", "Latin Jazz", "Contemporary Jazz"]),
        ("Blues", ["Delta Blues", "Chicago Blues", "Electric Blues", "Country Blues", "Texas Blues", "Blues Rock"]),
        ("Folk & Acoustic", ["Folk", "Contemporary Folk", "Indie Folk", "Dark Folk", "Neofolk", "Acoustic", "Singer-Songwriter", "Celtic Folk", "Nordic Folk", "Appalachian Folk", "Americana"]),
        ("Country", ["Traditional Country", "Outlaw Country", "Country Rock", "Modern Country", "Alt-Country", "Bluegrass", "Honky Tonk", "Western Swing", "Country Pop"]),
        ("Classical", ["Baroque", "Classical", "Romantic", "Impressionist", "Contemporary Classical", "Minimalism", "Chamber Music", "Orchestral", "Symphonic", "Choral", "Sacred Music"]),
        ("Cinematic", ["Film Score", "Trailer Music", "Epic Orchestral", "Hybrid Orchestral", "Dark Cinematic", "Ambient Cinematic", "Post-Rock Cinematic", "Sci-Fi Score", "Horror Score", "Fantasy Score"]),
        ("World", ["Middle Eastern", "Arabic", "Persian", "Turkish", "Indian Classical", "Bollywood", "Qawwali", "African Traditional", "Afrobeat", "Highlife", "Flamenco", "Tango", "Mariachi", "Bossa Nova", "Samba", "Reggaeton", "Celtic", "Nordic"]),
        ("Reggae / Dub", ["Reggae", "Roots Reggae", "Dub", "Dub Techno", "Digital Dub", "Dub Poetry", "Lovers Rock", "Dancehall"]),
        ("Atmosphere Tags", ["Melancholic", "Nostalgic", "Longing", "Hopeful", "Cathartic", "Apocalyptic", "Dreamlike", "Ethereal", "Spiritual", "Mystical", "Isolated", "Lonely", "Romantic", "Heroic", "Triumphant", "Dystopian", "Futuristic", "Cinematic", "Night-Time", "Urban", "Rural", "Winter", "Summer", "Oceanic", "Cosmic", "Haunted", "Sacred"]),
        ("Production Styles", ["Lo-Fi", "Hi-Fi", "Analog", "Vintage Tape", "Cassette", "Vinyl", "Radio Broadcast", "Wall of Sound", "Minimalist", "Maximalist", "Atmospheric", "Raw", "Polished", "Live Recording", "Studio Recording", "Intimate", "Huge Stereo Image", "Dense Layering", "Sparse Arrangement"]),
        ("Metal - Traditional", ["Classic Heavy Metal", "NWOBHM", "Epic Heavy Metal", "Speed Metal"]),
        ("Metal - Thrash", ["Bay Area Thrash", "Teutonic Thrash", "Blackened Thrash", "Technical Thrash"]),
        ("Metal - Death Metal", ["Old School Death Metal", "Swedish Death Metal", "Florida Death Metal", "Melodic Death Metal", "Technical Death Metal", "Progressive Death Metal", "Brutal Death Metal", "Slam Death Metal", "Cavernous Death Metal", "Death Doom"]),
        ("Metal - Black Metal", ["Raw Black Metal", "Atmospheric Black Metal", "Symphonic Black Metal", "Blackgaze", "Cascadian Black Metal", "Depressive Black Metal", "Ambient Black Metal", "Folk Black Metal", "Cosmic Black Metal", "Medieval Black Metal"]),
        ("Metal - Doom", ["Traditional Doom", "Epic Doom", "Gothic Doom", "Funeral Doom", "Death Doom", "Atmospheric Doom", "Stoner Doom", "Psychedelic Doom"]),
        ("Metal - Cores", ["Metalcore", "Melodic Metalcore", "Progressive Metalcore", "Atmospheric Metalcore", "Symphonic Metalcore", "Electronicore", "Deathcore", "Symphonic Deathcore", "Blackened Deathcore", "Downtempo Deathcore", "Progressive Deathcore", "Doomcore", "Sludgecore", "Mathcore", "Grindcore", "Cybercore", "Nintendocore", "Post-Hardcore", "Melodic Hardcore", "Metallic Hardcore", "Emotional Hardcore"]),
        ("Metal - Extreme", ["Grindcore", "Goregrind", "Deathgrind", "Noisegrind", "War Metal", "Bestial Black Metal"]),
        ("Metal - Modern", ["Djent", "Progressive Metal", "Post Metal", "Industrial Metal", "Nu Metal", "Alternative Metal"]),
        ("Industrial Expanded", ["Electro Industrial", "EBM", "Dark Electro", "Aggrotech", "Power Noise", "Rhythmic Noise", "Martial Industrial", "Industrial Ambient", "Industrial Dub", "Industrial Techno", "Apocalyptic Industrial"]),
        ("Goth & Dark Alternative", ["Gothic Rock", "Darkwave", "Coldwave", "Ethereal Wave", "Neoclassical Darkwave", "Deathrock", "Post Punk", "Gothic Doom", "Dark Cabaret"]),
        ("Shoegaze & Dream", ["Shoegaze", "Blackgaze", "Dream Pop", "Slowcore", "Sadcore", "Bedroom Pop", "Ethereal Pop", "Ambient Pop"]),
        ("Experimental & Avant-Garde", ["Avant-Garde Metal", "Experimental Electronic", "Musique Concrete", "Electroacoustic", "Sound Collage", "Noise Music", "Drone Music", "Glitch", "Lowercase", "Plunderphonics", "Generative Ambient", "Algorithmic Music", "Academic Modernism"]),
        ("Ambient Expanded", ["Dark Ambient", "Space Ambient", "Drone Ambient", "Isolationist Ambient", "Tribal Ambient", "Ritual Ambient", "Dungeon Synth", "Cryochamber Style Ambient", "Cinematic Ambient", "Deep Listening"]),
        ("Electronic - House", ["Deep House", "Progressive House", "Organic House", "Minimal House", "Afro House"]),
        ("Electronic - Techno", ["Detroit Techno", "Dub Techno", "Minimal Techno", "Industrial Techno", "Hypnotic Techno", "Hard Techno"]),
        ("Electronic - Trance", ["Goa Trance", "Psytrance", "Progressive Psytrance", "Dark Psy", "Forest Psy", "Full-On Psy"]),
        ("Electronic - Bass Music", ["Drum & Bass", "Liquid DnB", "Neurofunk", "Jungle", "Breakcore", "Future Garage"]),
        ("Electronic - Retro", ["Synthwave", "Retrowave", "Dark Synth", "Outrun", "Vaporwave", "Mallsoft", "Signalwave"]),
        ("Dub Expanded", ["Roots Dub", "UK Dub", "Dub Techno", "Ambient Dub", "Industrial Dub", "Psychedelic Dub", "Space Dub", "Steppers Dub"]),
        ("Folk & Ethnic - European", ["Celtic Folk", "Breton Folk", "Nordic Folk", "Medieval Folk", "Neofolk", "Balkan Folk"]),
        ("Folk & Ethnic - Middle East", ["Arabic Classical", "Levantine Folk", "Turkish Folk", "Persian Classical", "Sufi Music"]),
        ("Folk & Ethnic - Africa", ["Afrobeat", "Highlife", "Gnawa", "Tuareg Desert Blues", "West African Percussion"]),
        ("Folk & Ethnic - Asia", ["Japanese Traditional", "Shakuhachi Meditation", "Taiko Ensemble", "Chinese Classical", "Mongolian Throat Singing", "Tuvan Folk", "Gamelan", "Korean Court Music"]),
        ("Folk & Ethnic - India", ["Hindustani Classical", "Carnatic Classical", "Qawwali", "Bollywood", "Bhangra"]),
        ("Cinematic Expanded", ["Hollywood Score", "Trailer Music", "Dark Fantasy Score", "Horror Soundtrack", "Dystopian Score", "Cyberpunk Score", "Post-Apocalyptic Score", "Historical Epic", "Military Documentary", "Psychological Thriller"]),
        ("Religious & Sacred", ["Gregorian Chant", "Byzantine Chant", "Russian Orthodox Choir", "Sacred Choral", "Liturgical Ambient", "Monastic Chant", "Mystical Sufi", "Temple Ritual Music"]),
        ("Unusual Hybrid Presets", ["Cathedral Black Metal", "Dream Pop Deathcore", "Industrial Dub Shoegaze", "Appalachian Doom", "Cyberpunk Gospel", "Viking Synthwave", "Ritual Ambient Techno", "Blackened Trip Hop", "Desert Psychedelic Doom", "Space Western", "Monastic Industrial", "Post-Apocalyptic Folk", "Gothic Americana", "Dark Jazz Noir", "Haunted Carnival", "Soviet Space Ambient", "Nuclear Winter Soundtrack", "Cosmic Funeral Doom", "Medieval Cyberpunk", "Deep Ocean Drone", "Urban Isolation Soundscape", "Drone Pilot Night Flight", "Rainy Suburban Nostalgia", "Forgotten Shopping Mall Vaporwave", "Last Train Home", "Cold War Numbers Station", "Arctic Research Station Ambient", "Abandoned Cathedral Choir"])
    ]

    static var allTags: [StyleTag] {
        categories.flatMap { category, names in
            names.map { StyleTag(category: category, name: $0) }
        }
    }
}

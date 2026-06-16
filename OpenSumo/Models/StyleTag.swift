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
        ("Production Styles", ["Lo-Fi", "Hi-Fi", "Analog", "Vintage Tape", "Cassette", "Vinyl", "Radio Broadcast", "Wall of Sound", "Minimalist", "Maximalist", "Atmospheric", "Raw", "Polished", "Live Recording", "Studio Recording", "Intimate", "Huge Stereo Image", "Dense Layering", "Sparse Arrangement"])
    ]

    static var allTags: [StyleTag] {
        categories.flatMap { category, names in
            names.map { StyleTag(category: category, name: $0) }
        }
    }
}

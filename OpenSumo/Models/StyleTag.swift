import Foundation

struct StyleTag: Identifiable, Hashable, Sendable {
    var category: String
    var name: String
    var id: String { "\(category)::\(name)" }
}

enum StyleTagCategoryDisplay {
    static func normalized(_ category: String) -> String {
        if category.hasPrefix("Folk & Ethnic") || category == "Folk & Acoustic" || category == "World" || category == "World Expanded" {
            return "Folk & Ethnic"
        }
        if category.hasPrefix("Rock - ") {
            return "Rock"
        }
        return category
    }
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
        ("Rock - Foundational", ["Rock and Roll", "Early Rock and Roll", "Classic Rock", "Mainstream Rock", "Album Rock", "Heritage Rock", "Arena Rock", "Stadium Rock", "Anthem Rock", "Radio Rock", "Guitar Rock"]),
        ("Rock - Proto", ["Rockabilly", "Blues Rock", "Rhythm and Blues Rock", "Skiffle", "Garage Rock", "Proto-Punk", "Proto-Metal", "British Invasion"]),
        ("Rock - Classic Era", ["Hard Rock", "Soft Rock", "Southern Rock", "Boogie Rock", "Pub Rock", "Heartland Rock", "Country Rock", "Roots Rock", "Swamp Rock", "Yacht Rock", "Folk Rock"]),
        ("Rock - Psychedelic Family", ["Psychedelic Rock", "Acid Rock", "Neo-Psychedelia", "Space Rock", "Cosmic Rock", "Heavy Psychedelia", "Psychedelic Folk", "Psychedelic Pop", "Psychedelic Blues", "Psychedelic Garage Rock"]),
        ("Rock - Progressive Family", ["Progressive Rock", "Symphonic Progressive Rock", "Art Rock", "Canterbury Scene", "Neo-Prog", "Progressive Folk", "Progressive Hard Rock", "Progressive Alternative Rock", "Eclectic Prog", "Retro Progressive Rock", "Experimental Progressive Rock"]),
        ("Rock - Art & Experimental", ["Art Rock", "Avant-Rock", "Experimental Rock", "Noise Rock", "No Wave", "Industrial Rock", "Electro Rock", "Electronic Rock", "Post-Industrial Rock", "Sound Collage Rock", "Drone Rock"]),
        ("Rock - Alternative Family", ["Alternative Rock", "Alternative Pop Rock", "Alternative Hard Rock", "Modern Rock", "College Rock", "Indie Rock", "Mainstream Alternative", "Adult Alternative"]),
        ("Rock - Indie Family", ["Indie Rock", "Indie Pop Rock", "Lo-Fi Indie Rock", "Jangle Pop", "Slacker Rock", "Twee Rock", "Bedroom Rock", "Dream Indie Rock", "Chamber Indie Rock"]),
        ("Rock - Post-Punk Family", ["Post-Punk", "Gothic Rock", "Darkwave Rock", "Deathrock", "Coldwave Rock", "Post-Punk Revival", "Art Punk", "Neo-Gothic Rock"]),
        ("Rock - Punk-Derived", ["Punk Rock", "Garage Punk", "Pop Punk", "Skate Punk", "Street Punk", "Horror Punk", "Folk Punk", "Celtic Punk", "Post-Punk", "Proto-Punk", "Punk Blues"]),
        ("Rock - Grunge Family", ["Grunge", "Post-Grunge", "Alternative Grunge", "Heavy Grunge", "Acoustic Grunge", "Neo-Grunge"]),
        ("Rock - Shoegaze Family", ["Shoegaze", "Dream Pop Rock", "Blackgaze", "Nu-Gaze", "Ambient Shoegaze", "Post-Shoegaze", "Noise Pop", "Ethereal Shoegaze"]),
        ("Rock - Post-Rock Family", ["Post-Rock", "Cinematic Post-Rock", "Instrumental Post-Rock", "Ambient Post-Rock", "Heavy Post-Rock", "Orchestral Post-Rock", "Experimental Post-Rock", "Drone Post-Rock"]),
        ("Rock - Slowcore Family", ["Slowcore", "Sadcore", "Dreamcore", "Atmospheric Slowcore", "Indie Slowcore", "Post-Rock Slowcore"]),
        ("Rock - Math Family", ["Math Rock", "Technical Math Rock", "Progressive Math Rock", "Instrumental Math Rock", "Experimental Math Rock"]),
        ("Rock - Garage Family", ["Garage Rock", "Garage Revival", "Garage Punk", "Garage Blues", "Fuzz Garage Rock", "Lo-Fi Garage Rock"]),
        ("Rock - Blues-Derived", ["Blues Rock", "Electric Blues Rock", "Southern Blues Rock", "Psychedelic Blues Rock", "Hard Blues Rock", "Delta Blues Rock"]),
        ("Rock - Folk-Derived", ["Folk Rock", "Electric Folk", "Progressive Folk", "Acid Folk", "Neo-Folk Rock", "Contemporary Folk Rock"]),
        ("Rock - Country-Derived", ["Country Rock", "Southern Rock", "Americana Rock", "Alt-Country Rock", "Desert Country Rock"]),
        ("Rock - Southern Family", ["Southern Rock", "Outlaw Rock", "Swamp Rock", "Boogie Rock", "Country Blues Rock"]),
        ("Rock - Desert Family", ["Desert Rock", "Stoner Rock", "Palm Desert Rock", "Heavy Desert Rock", "Psychedelic Desert Rock"]),
        ("Rock - Stoner Family", ["Stoner Rock", "Fuzz Rock", "Heavy Stoner Rock", "Space Stoner Rock", "Psychedelic Stoner Rock"]),
        ("Rock - Gothic Family", ["Gothic Rock", "Dark Rock", "Romantic Gothic Rock", "Ethereal Gothic Rock", "Cathedral Gothic Rock", "Neo-Gothic Rock"]),
        ("Rock - Industrial Family", ["Industrial Rock", "Electro Rock", "Electronic Rock", "Industrial Alternative Rock", "Industrial Gothic Rock", "Cyber Rock"]),
        ("Rock - Electronic Rock", ["Synth Rock", "Electro Rock", "Digital Rock", "Electronic Alternative Rock", "Dance Rock", "New Wave Rock"]),
        ("Rock - New Wave Family", ["New Wave", "Synth Rock", "New Romantic", "Power Pop", "New Wave Pop Rock", "Post-New Wave"]),
        ("Rock - Pop-Rock Family", ["Pop Rock", "Power Pop", "Sunshine Pop Rock", "Jangle Pop", "Adult Contemporary Rock", "Soft Pop Rock"]),
        ("Rock - Jangle Family", ["Jangle Rock", "Jangle Pop", "College Jangle Rock", "Folk Jangle Rock"]),
        ("Rock - Noise Family", ["Noise Rock", "Harsh Noise Rock", "Experimental Noise Rock", "Industrial Noise Rock", "Feedback Rock"]),
        ("Rock - Drone Family", ["Drone Rock", "Ambient Drone Rock", "Experimental Drone Rock", "Space Drone Rock"]),
        ("Rock - Regional United States", ["Heartland Rock", "Southern Rock", "West Coast Rock", "Americana Rock", "Desert Rock"]),
        ("Rock - Regional United Kingdom", ["British Rock", "Britpop", "Madchester", "Baggy"]),
        ("Rock - Regional Australia", ["Australian Pub Rock", "Australian Alternative Rock", "Australian Indie Rock"]),
        ("Rock - Regional Germany", ["Krautrock", "Kosmische Musik"]),
        ("Rock - Regional Japan", ["Japanese Alternative Rock", "Japanese Shoegaze", "Visual Kei Rock"]),
        ("Rock - Regional Latin America", ["Latin Rock", "Rock en Espanol", "Andean Rock"]),
        ("Rock - Regional Scandinavia", ["Nordic Rock", "Scandinavian Alternative Rock"]),
        ("Rock - Atmospheric / Mood-Oriented", ["Melancholic Rock", "Nostalgic Rock", "Winter Rock", "Autumn Rock", "Nocturnal Rock", "Rainy-Day Rock", "Oceanic Rock", "Coastal Rock", "Rural Rock", "Urban Rock", "Cinematic Rock", "Dreamlike Rock", "Ethereal Rock", "Apocalyptic Rock", "Dystopian Rock", "Cosmic Rock", "Spiritual Rock", "Sacred Rock"]),
        ("Rock - Hybrid Presets", ["Cathedral Shoegaze", "Dream Pop Rock", "Industrial Post-Rock", "Atmospheric Alternative Rock", "Nordic Winter Rock", "Desert Highway Rock", "Rainy Night Indie Rock", "Cosmic Space Rock", "Apocalyptic Arena Rock", "Cinematic Slowcore", "Gothic Americana", "Blackened Shoegaze Rock", "Oceanic Post-Rock", "Arctic Post-Rock", "Analog Nostalgia Rock", "Cold War Alternative Rock", "Abandoned Factory Rock", "Urban Isolation Rock", "Last Train Home Rock", "Late-Night Radio Rock", "Autumn Library Rock", "Twilight Coastal Rock", "Stormfront Post-Rock", "Midnight Highway Rock", "Small Town Heartland Rock", "Soviet Space Rock", "Forgotten City Indie Rock"]),
        ("Metal", ["Heavy Metal", "Traditional Metal", "Power Metal", "Speed Metal", "Thrash Metal", "Death Metal", "Melodic Death Metal", "Technical Death Metal", "Brutal Death Metal", "Black Metal", "Atmospheric Black Metal", "Symphonic Black Metal", "Depressive Suicidal Black Metal", "Blackgaze", "Doom Metal", "Funeral Doom", "Epic Doom", "Death Doom", "Gothic Doom", "Sludge Metal", "Groove Metal", "Metalcore", "Deathcore", "Progressive Metal", "Djent", "Symphonic Metal", "Folk Metal", "Viking Metal", "Industrial Metal", "Nu Metal", "Post-Metal", "Avant-Garde Metal", "War Metal"]),
        ("Punk", ["Punk Rock", "Hardcore Punk", "Melodic Hardcore", "Post-Hardcore", "Pop Punk", "Skate Punk", "Crust Punk", "D-Beat", "Anarcho Punk", "Street Punk", "Oi!", "Horror Punk", "Folk Punk", "Celtic Punk"]),
        ("Electronic", ["Ambient", "Dark Ambient", "Drone", "IDM", "Glitch", "Experimental Electronic", "Downtempo", "Chillout", "Trip-Hop", "Breakbeat", "Big Beat", "Electronica", "Electro", "Electroclash", "Synthwave", "Darkwave", "Coldwave", "Retrowave", "Vaporwave", "Future Bass", "Drum & Bass", "Jungle", "Liquid DnB", "Neurofunk", "Dubstep", "Brostep", "UK Garage", "2-Step", "House", "Deep House", "Progressive House", "Tech House", "Minimal House", "Acid House", "Trance", "Progressive Trance", "Psytrance", "Goa Trance", "Hard Trance", "Techno", "Minimal Techno", "Detroit Techno", "Industrial Techno", "Hardstyle", "Hardcore Techno", "Gabber", "Happy Hardcore"]),
        ("Industrial", ["Industrial", "Industrial Rock", "Industrial Metal", "EBM", "Aggrotech", "Electro-Industrial", "Power Noise", "Rhythmic Noise", "Dark Electro", "Industrial Ambient", "Industrial Dub", "Martial Industrial"]),
        ("Pop", ["Pop", "Synth Pop", "Electro Pop", "Dream Pop", "Indie Pop", "Art Pop", "Chamber Pop", "Dance Pop", "Hyperpop", "Bubblegum Pop", "Teen Pop", "Power Pop", "Contemporary Pop"]),
        ("Pop - Mainstream", ["Contemporary Pop", "Mainstream Pop", "Adult Contemporary", "Radio Pop", "Commercial Pop", "Chart Pop", "Modern Pop", "Singer-Songwriter Pop", "Soft Pop", "Easy Listening Pop", "Pop Ballad", "Piano Pop", "Acoustic Pop", "Guitar Pop", "Anthemic Pop"]),
        ("Pop - Classic", ["Traditional Pop", "Vocal Pop", "Crooner Pop", "Tin Pan Alley Pop", "Sunshine Pop", "Bubblegum Pop", "Brill Building Pop", "Orchestral Pop", "Baroque Pop", "Chamber Pop", "Lounge Pop", "Sophisti-Pop"]),
        ("Pop - Rock", ["Pop Rock", "Arena Pop Rock", "Alternative Pop Rock", "Piano Rock Pop", "Guitar Driven Pop", "Power Pop", "Heartland Pop Rock", "Stadium Pop", "Indie Pop Rock"]),
        ("Pop - Indie & Alternative", ["Indie Pop", "Alternative Pop", "Art Pop", "Experimental Pop", "Dream Pop", "Bedroom Pop", "Lo-Fi Pop", "Ambient Pop", "Psychedelic Pop", "Ethereal Pop", "Hypnagogic Pop", "Slow Pop", "Soft Indie Pop", "Sad Pop", "Dark Pop", "Noir Pop"]),
        ("Pop - Electronic", ["Synth Pop", "Electro Pop", "Dance Pop", "Future Pop", "Future Bass Pop", "Hyperpop", "Glitch Pop", "Bubblegum Bass", "Electropop Ballad", "Digital Pop", "Chill Pop", "Ambient Electropop", "Cyber Pop", "Dreamwave Pop", "Synthwave Pop", "Retrowave Pop"]),
        ("Pop - Retro 1950s", ["Doo-Wop Pop", "Teen Idol Pop", "Early Rock & Roll Pop"]),
        ("Pop - Retro 1960s", ["British Invasion Pop", "Sunshine Pop", "Psychedelic Pop", "Girl Group Pop"]),
        ("Pop - Retro 1970s", ["Soft Rock Pop", "Yacht Pop", "Disco Pop"]),
        ("Pop - Retro 1980s", ["New Wave Pop", "Synth Pop", "Sophisti-Pop", "Arena Pop", "Power Ballad Pop"]),
        ("Pop - Retro 1990s", ["Adult Contemporary Pop", "Teen Pop", "Europop", "Dance Pop", "Alternative Pop"]),
        ("Pop - Retro 2000s", ["TRL Pop", "Pop Punk Pop", "R&B Pop", "Electro Pop"]),
        ("Pop - Retro 2010s", ["EDM Pop", "Indie Pop", "Tropical Pop", "Bedroom Pop"]),
        ("Pop - Retro 2020s", ["TikTok Pop", "Hyperpop", "Alternative Digital Pop"]),
        ("Pop - Dance-Oriented", ["Dance Pop", "Club Pop", "Festival Pop", "EDM Pop", "House Pop", "Progressive House Pop", "Electro House Pop", "Tropical Pop", "Trance Pop", "Future House Pop", "Nu Disco Pop", "Disco Pop", "Funk Pop"]),
        ("Pop - R&B-Influenced", ["Contemporary R&B Pop", "Soul Pop", "Neo-Soul Pop", "Quiet Storm Pop", "Gospel Pop", "Urban Pop", "Smooth Pop", "Blue-Eyed Soul Pop"]),
        ("Pop - Hip-Hop Influenced", ["Pop Rap", "Trap Pop", "Melodic Trap Pop", "Cloud Pop", "Hip-Hop Pop", "Urban Contemporary Pop", "Rap-Pop Fusion", "Emo Rap Pop"]),
        ("Pop - Rock Influenced", ["Pop Punk", "Emo Pop", "Alternative Pop Rock", "Post-Grunge Pop", "Soft Alternative Pop", "Power Pop", "Guitar Pop"]),
        ("Pop - Dreamy & Atmospheric", ["Dream Pop", "Ethereal Pop", "Ambient Pop", "Shoegaze Pop", "Cinematic Pop", "Atmospheric Pop", "Melancholic Pop", "Nostalgic Pop", "Winter Pop", "Night-Time Pop", "Oceanic Pop", "Cosmic Pop"]),
        ("Pop - Experimental", ["Avant-Pop", "Art Pop", "Progressive Pop", "Noise Pop", "Glitch Pop", "Experimental Electronic Pop", "Electroacoustic Pop", "Post-Pop", "Deconstructed Pop", "Leftfield Pop", "Outsider Pop"]),
        ("Pop - Dark", ["Dark Pop", "Gothic Pop", "Noir Pop", "Industrial Pop", "Darkwave Pop", "Post-Punk Pop", "Melancholic Pop", "Cinematic Dark Pop", "Apocalyptic Pop"]),
        ("Pop - Emotional", ["Heartbreak Pop", "Breakup Pop", "Cathartic Pop", "Inspirational Pop", "Empowerment Pop", "Romantic Pop", "Longing Pop", "Nostalgic Pop", "Reflective Pop", "Bittersweet Pop"]),
        ("Pop - Regional Europe", ["Europop", "French Pop", "Chanson Pop", "Italian Pop", "Spanish Pop", "German Pop", "Nordic Pop", "Scandinavian Pop", "Balkan Pop", "Russian Pop"]),
        ("Pop - Regional Latin America", ["Latin Pop", "Tropical Pop", "Reggaeton Pop", "Urban Latin Pop", "Salsa Pop", "Cumbia Pop", "Brazilian Pop", "Bossa Pop"]),
        ("Pop - Regional Asia", ["J-Pop", "City Pop", "Shibuya-Kei", "Anime Pop", "K-Pop", "Mandopop", "Cantopop", "Thai Pop", "Vietnamese Pop", "Filipino Pop", "Indonesian Pop"]),
        ("Pop - Regional South Asia", ["Bollywood Pop", "Indi-Pop", "Pakistani Pop", "Bengali Pop"]),
        ("Pop - Regional Middle East", ["Arabic Pop", "Persian Pop", "Turkish Pop", "Levantine Pop"]),
        ("Pop - Regional Africa", ["Afro Pop", "Afrobeat Pop", "Afroswing", "Highlife Pop", "Amapiano Pop"]),
        ("Pop - Holiday & Seasonal", ["Christmas Pop", "Winter Pop", "Summer Pop", "Beach Pop", "Holiday Ballad Pop", "Festive Pop"]),
        ("Pop - Internet-Era", ["Viral Pop", "TikTok Pop", "Streaming Pop", "Bedroom Producer Pop", "DIY Pop", "Social Media Pop", "Meme Pop"]),
        ("Pop - Hybrid Presets", ["Dream Pop Heartbreak", "Shoegaze Pop", "Industrial Pop Noir", "Gothic Synth Pop", "Cathedral Pop", "Cinematic Dark Pop", "Hyperpop Meltdown", "Nordic Winter Pop", "Analog Nostalgia Pop", "Rainy Night Pop", "Urban Isolation Pop", "Oceanic Dream Pop", "Cosmic Synth Pop", "Desert Pop", "Ethereal Choir Pop", "Apocalyptic Pop Anthem", "Post-Rock Pop", "Blackgaze Pop", "Trip-Hop Pop", "Industrial Dub Pop", "Celtic Dream Pop", "Japanese City Pop Revival", "Soviet Synth Pop", "Arctic Midnight Pop", "Haunted Mall Pop", "Retro-Futurist Pop", "Lonely Suburb Pop", "Last Train Home Pop", "Late-Night Radio Pop", "Warm Cassette Pop"]),
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
        ("Folk & Ethnic - Indigenous & First Nations", ["Australian Aboriginal Traditional", "Aboriginal Didgeridoo", "Aboriginal Songlines", "Torres Strait Islander", "Maori Traditional", "Native American Plains", "Native American Powwow", "Inuit Throat Singing", "First Nations Canadian", "Amazonian Tribal", "Andean Indigenous", "Mapuche Traditional", "Sami Joik", "Ainu Traditional"]),
        ("Folk & Ethnic - Celtic", ["Irish Traditional", "Irish Pub Folk", "Irish Ballads", "Irish Rebel Songs", "Scottish Folk", "Scottish Pipe Band", "Scottish Gaelic", "Welsh Folk", "Breton Folk", "Cornish Folk", "Celtic Harp", "Celtic Fusion"]),
        ("Folk & Ethnic - Nordic & Scandinavian", ["Nordic Folk", "Swedish Folk", "Norwegian Folk", "Danish Folk", "Finnish Folk", "Sami Joik", "Icelandic Folk", "Viking Music", "Nordic Ritual", "Nordic Pagan Folk", "Nordic Ambient Folk"]),
        ("Folk & Ethnic - English & Western European", ["English Folk", "Morris Dance", "Sea Shanties", "French Folk", "Occitan Folk", "Basque Folk", "Flemish Folk", "Dutch Folk", "Swiss Alpine Folk", "Yodel Music", "Austrian Folk", "Bavarian Folk"]),
        ("Folk & Ethnic - Balkan", ["Balkan Folk", "Serbian Folk", "Croatian Folk", "Bosnian Sevdah", "Macedonian Folk", "Bulgarian Choir", "Bulgarian Folk", "Romanian Folk", "Romanian Lautari", "Albanian Folk", "Greek Folk", "Pontic Greek", "Thracian Folk"]),
        ("Folk & Ethnic - Eastern Europe", ["Polish Folk", "Ukrainian Folk", "Belarusian Folk", "Russian Folk", "Cossack Songs", "Moldovan Folk", "Carpathian Folk", "Rusyn Folk"]),
        ("Folk & Ethnic - Mediterranean", ["Sicilian Folk", "Sardinian Folk", "Neapolitan Folk", "Corsican Polyphony", "Maltese Folk", "Cypriot Folk", "Greek Island Music"]),
        ("Folk & Ethnic - Middle Eastern Expanded", ["Arabic Classical", "Levantine Folk", "Bedouin Music", "Egyptian Folk", "Iraqi Maqam", "Syrian Traditional", "Lebanese Traditional", "Jordanian Folk", "Palestinian Folk", "Yemeni Traditional", "Gulf Khaleeji", "Omani Folk", "Qatari Folk", "Bahraini Folk", "Kuwaiti Folk"]),
        ("Folk & Ethnic - Turkish", ["Anatolian Folk", "Turkish Classical", "Turkish Sufi", "Ottoman Court Music", "Turkish Psychedelic Folk", "Turkish Roma"]),
        ("Folk & Ethnic - Persian & Iranian", ["Persian Classical", "Persian Folk", "Kurdish Folk", "Azeri Folk", "Luri Folk", "Baluchi Folk", "Sufi Persian", "Iranian Epic Music"]),
        ("Folk & Ethnic - Caucasus", ["Georgian Polyphonic Choir", "Armenian Folk", "Armenian Duduk", "Azerbaijani Mugham", "Circassian Folk", "Chechen Folk"]),
        ("Folk & Ethnic - Jewish Traditions", ["Klezmer", "Ashkenazi Folk", "Sephardic Folk", "Mizrahi Music", "Hasidic Music", "Cantorial Chant"]),
        ("Folk & Ethnic - North African", ["Berber Folk", "Amazigh Traditional", "Gnawa", "Rai", "Chaabi", "Andalusian Classical", "Tuareg Music", "Saharan Desert Blues", "Moroccan Folk", "Algerian Folk", "Tunisian Folk", "Libyan Folk"]),
        ("Folk & Ethnic - West Africa", ["Afrobeat", "Highlife", "Juju", "Fuji", "Palm Wine Music", "Griot Music", "Mandinka Traditional", "Wolof Folk", "Ewe Traditional", "Akan Traditional", "Hausa Folk", "Yoruba Traditional"]),
        ("Folk & Ethnic - Central Africa", ["Congolese Rumba", "Soukous", "Pygmy Polyphony", "Central African Ritual Music"]),
        ("Folk & Ethnic - East Africa", ["Ethiopian Traditional", "Ethiopian Jazz", "Tizita", "Eritrean Folk", "Somali Folk", "Kenyan Folk", "Tanzanian Traditional", "Ugandan Traditional", "Swahili Coastal Music"]),
        ("Folk & Ethnic - Southern Africa", ["Zulu Traditional", "Xhosa Traditional", "Mbube", "Isicathamiya", "Tswana Folk", "Shona Mbira", "Zimbabwean Traditional", "South African Township Music"]),
        ("Folk & Ethnic - Indian Classical", ["Hindustani Classical", "Carnatic Classical", "Dhrupad", "Khayal", "Thumri", "Bhajan", "Kirtan"]),
        ("Folk & Ethnic - Indian Regional", ["Punjabi Folk", "Bhangra", "Rajasthani Folk", "Gujarati Folk", "Bengali Folk", "Baul", "Assamese Folk", "Kashmiri Folk", "Tamil Folk", "Telugu Folk", "Marathi Folk", "Kerala Folk"]),
        ("Folk & Ethnic - Pakistan", ["Qawwali", "Sufi Qawwali", "Punjabi Folk", "Sindhi Folk", "Balochi Folk", "Pashtun Folk"]),
        ("Folk & Ethnic - Bangladesh", ["Baul", "Bengali Folk", "Bhatiali", "Nazrul Geeti"]),
        ("Folk & Ethnic - Sri Lanka", ["Kandyan Music", "Sinhala Folk", "Tamil Sri Lankan Folk"]),
        ("Folk & Ethnic - Nepal & Himalayas", ["Nepali Folk", "Sherpa Traditional", "Tibetan Folk", "Tibetan Chant", "Bhutanese Traditional"]),
        ("Folk & Ethnic - China", ["Chinese Classical", "Guqin Music", "Guzheng Music", "Pipa Music", "Chinese Opera", "Mongolian Folk", "Uyghur Folk", "Tibetan Traditional", "Chinese Court Music"]),
        ("Folk & Ethnic - Mongolia", ["Mongolian Folk", "Morin Khuur", "Long Song", "Mongolian Throat Singing"]),
        ("Folk & Ethnic - Central Asia", ["Kazakh Folk", "Kyrgyz Folk", "Uzbek Folk", "Tajik Folk", "Turkmen Folk", "Silk Road Traditional"]),
        ("Folk & Ethnic - Japan", ["Gagaku", "Shakuhachi", "Koto Music", "Shamisen Music", "Taiko Ensemble", "Minyo Folk", "Okinawan Folk", "Japanese Festival Music", "Buddhist Chant"]),
        ("Folk & Ethnic - Korea", ["Pansori", "Gugak", "Samul Nori", "Korean Court Music", "Korean Shamanic Music"]),
        ("Folk & Ethnic - Indonesia", ["Gamelan", "Javanese Gamelan", "Balinese Gamelan", "Sundanese Folk"]),
        ("Folk & Ethnic - Malaysia", ["Malay Traditional", "Gamelan Melayu"]),
        ("Folk & Ethnic - Thailand", ["Thai Classical", "Thai Folk"]),
        ("Folk & Ethnic - Cambodia", ["Khmer Classical", "Khmer Folk"]),
        ("Folk & Ethnic - Laos", ["Lao Folk", "Mor Lam"]),
        ("Folk & Ethnic - Vietnam", ["Vietnamese Traditional", "Ca Tru", "Quan Ho"]),
        ("Folk & Ethnic - Myanmar", ["Burmese Traditional", "Burmese Court Music"]),
        ("Folk & Ethnic - Philippines", ["Kundiman", "Filipino Folk", "Tribal Philippine Music"]),
        ("Folk & Ethnic - Pacific Islands", ["Polynesian Traditional", "Hawaiian Traditional", "Hawaiian Slack Key Guitar", "Tahitian Music", "Samoan Traditional", "Tongan Traditional", "Fijian Folk", "Micronesian Traditional", "Melanesian Traditional"]),
        ("Folk & Ethnic - Mexico", ["Mariachi", "Ranchera", "Son Jarocho", "Huapango", "Norteno", "Corrido"]),
        ("Folk & Ethnic - Caribbean", ["Cuban Son", "Rumba", "Mambo", "Salsa", "Calypso", "Soca", "Reggae", "Dancehall"]),
        ("Folk & Ethnic - South America", ["Andean Folk", "Quechua Folk", "Pan Flute Ensemble", "Peruvian Folk", "Bolivian Folk", "Colombian Cumbia", "Colombian Vallenato", "Venezuelan Joropo", "Brazilian Samba", "Choro", "Forro", "Bossa Nova", "Argentine Tango", "Uruguayan Candombe", "Paraguayan Harp"]),
        ("Folk & Ethnic - Sacred & Ritual", ["Gregorian Chant", "Byzantine Chant", "Russian Orthodox Choir", "Georgian Orthodox Chant", "Armenian Sacred Music", "Coptic Chant", "Syriac Chant", "Islamic Nasheed", "Sufi Dhikr", "Hindu Temple Music", "Buddhist Chant", "Tibetan Monastic Chant", "Shinto Ritual Music", "Shamanic Drum Ritual", "Pagan Ritual Folk"]),
        ("Cinematic Expanded", ["Hollywood Score", "Trailer Music", "Dark Fantasy Score", "Horror Soundtrack", "Dystopian Score", "Cyberpunk Score", "Post-Apocalyptic Score", "Historical Epic", "Military Documentary", "Psychological Thriller"]),
        ("Religious & Sacred", ["Gregorian Chant", "Byzantine Chant", "Russian Orthodox Choir", "Sacred Choral", "Liturgical Ambient", "Monastic Chant", "Mystical Sufi", "Temple Ritual Music"]),
        ("Unusual Hybrid Presets", ["Cathedral Black Metal", "Dream Pop Deathcore", "Industrial Dub Shoegaze", "Appalachian Doom", "Cyberpunk Gospel", "Viking Synthwave", "Ritual Ambient Techno", "Blackened Trip Hop", "Desert Psychedelic Doom", "Space Western", "Monastic Industrial", "Post-Apocalyptic Folk", "Gothic Americana", "Dark Jazz Noir", "Haunted Carnival", "Soviet Space Ambient", "Nuclear Winter Soundtrack", "Cosmic Funeral Doom", "Medieval Cyberpunk", "Deep Ocean Drone", "Urban Isolation Soundscape", "Drone Pilot Night Flight", "Rainy Suburban Nostalgia", "Forgotten Shopping Mall Vaporwave", "Last Train Home", "Cold War Numbers Station", "Arctic Research Station Ambient", "Abandoned Cathedral Choir"])
    ]

    static var allTags: [StyleTag] {
        let tags = categories.flatMap { category, names in
            names.map { StyleTag(category: StyleTagCategoryDisplay.normalized(category), name: $0) }
        }
        return Array(Set(tags)).sorted {
            if $0.category == $1.category {
                return $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedAscending
            }
            return $0.category.localizedCaseInsensitiveCompare($1.category) == .orderedAscending
        }
    }
}

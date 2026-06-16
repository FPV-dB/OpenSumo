import Foundation
import SQLite3

final class StyleTagStore {
    private var db: OpaquePointer?

    init() {
        do {
            try open()
            try migrate()
            try seed()
        } catch {
            db = nil
        }
    }

    deinit {
        sqlite3_close(db)
    }

    func loadTags() -> [StyleTag] {
        guard let db else { return StyleTagCatalog.allTags }
        let sql = "SELECT category, name FROM style_tags ORDER BY category_order, name COLLATE NOCASE"
        var statement: OpaquePointer?
        guard sqlite3_prepare_v2(db, sql, -1, &statement, nil) == SQLITE_OK else {
            return StyleTagCatalog.allTags
        }
        defer { sqlite3_finalize(statement) }

        var tags: [StyleTag] = []
        while sqlite3_step(statement) == SQLITE_ROW {
            let category = StyleTagCategoryDisplay.normalized(String(cString: sqlite3_column_text(statement, 0)))
            let name = String(cString: sqlite3_column_text(statement, 1))
            tags.append(StyleTag(category: category, name: name))
        }
        let uniqueTags = Array(Set(tags)).sorted {
            if $0.category == $1.category {
                return $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedAscending
            }
            return $0.category.localizedCaseInsensitiveCompare($1.category) == .orderedAscending
        }
        return uniqueTags.isEmpty ? StyleTagCatalog.allTags : uniqueTags
    }

    private func open() throws {
        let url = databaseURL()
        try FileManager.default.createDirectory(at: url.deletingLastPathComponent(), withIntermediateDirectories: true)
        guard sqlite3_open(url.path, &db) == SQLITE_OK else {
            throw StyleTagStoreError.openFailed
        }
    }

    private func migrate() throws {
        try execute("""
            CREATE TABLE IF NOT EXISTS style_tags (
                tag_id INTEGER PRIMARY KEY AUTOINCREMENT,
                category TEXT NOT NULL,
                name TEXT NOT NULL,
                category_order INTEGER NOT NULL,
                UNIQUE(category, name)
            )
            """)
        try execute("CREATE INDEX IF NOT EXISTS idx_style_tags_search ON style_tags(name COLLATE NOCASE, category COLLATE NOCASE)")
    }

    private func seed() throws {
        for (categoryIndex, entry) in StyleTagCatalog.categories.enumerated() {
            for name in entry.1 {
                try insert(category: StyleTagCategoryDisplay.normalized(entry.0), name: name, categoryOrder: categoryIndex)
            }
        }
    }

    private func insert(category: String, name: String, categoryOrder: Int) throws {
        guard let db else { return }
        var statement: OpaquePointer?
        let sql = "INSERT OR IGNORE INTO style_tags(category, name, category_order) VALUES (?, ?, ?)"
        guard sqlite3_prepare_v2(db, sql, -1, &statement, nil) == SQLITE_OK else {
            throw StyleTagStoreError.queryFailed
        }
        defer { sqlite3_finalize(statement) }
        sqlite3_bind_text(statement, 1, category, -1, SQLITE_TRANSIENT)
        sqlite3_bind_text(statement, 2, name, -1, SQLITE_TRANSIENT)
        sqlite3_bind_int(statement, 3, Int32(categoryOrder))
        guard sqlite3_step(statement) == SQLITE_DONE else {
            throw StyleTagStoreError.queryFailed
        }
    }

    private func execute(_ sql: String) throws {
        guard sqlite3_exec(db, sql, nil, nil, nil) == SQLITE_OK else {
            throw StyleTagStoreError.queryFailed
        }
    }

    private func databaseURL() -> URL {
        let base = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first
            ?? FileManager.default.homeDirectoryForCurrentUser
        return base.appendingPathComponent("OpenSumo", isDirectory: true).appendingPathComponent("style-tags.sqlite")
    }
}

private enum StyleTagStoreError: Error {
    case openFailed
    case queryFailed
}

private let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)

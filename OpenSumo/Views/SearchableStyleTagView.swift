import SwiftUI

struct SearchableStyleTagView: View {
    let title: String
    let tags: [StyleTag]
    @Binding var selection: [String]
    @State private var searchText = ""
    @State private var categoryFilter = "All"

    private var categories: [String] {
        ["All"] + Array(Set(tags.map(\.category))).sorted()
    }

    private var filteredTags: [StyleTag] {
        tags.filter { tag in
            let matchesCategory = categoryFilter == "All" || tag.category == categoryFilter
            let query = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
            let matchesSearch = query.isEmpty
                || tag.name.localizedCaseInsensitiveContains(query)
                || tag.category.localizedCaseInsensitiveContains(query)
            return matchesCategory && matchesSearch
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(title)
                    .font(.headline)
                Spacer()
                Text("\(selection.count) selected")
                    .font(.caption)
                    .foregroundStyle(AppTheme.secondaryText)
            }

            HStack {
                TextField("Search styles, moods, production tags", text: $searchText)
                    .textFieldStyle(.roundedBorder)
                Picker("Category", selection: $categoryFilter) {
                    ForEach(categories, id: \.self) { category in
                        Text(category).tag(category)
                    }
                }
                .frame(width: 210)
            }

            if !selection.isEmpty {
                FlowLayout(spacing: 8) {
                    ForEach(selection, id: \.self) { value in
                        selectedChip(value)
                    }
                }
                .padding(.vertical, 2)
            }

            ScrollView {
                FlowLayout(spacing: 8) {
                    ForEach(filteredTags) { tag in
                        tagChip(tag)
                    }
                }
                .padding(.vertical, 4)
            }
            .frame(minHeight: 170, maxHeight: 310)
            .padding(10)
            .background(AppTheme.control, in: RoundedRectangle(cornerRadius: 8, style: .continuous))
            .overlay(RoundedRectangle(cornerRadius: 8, style: .continuous).strokeBorder(AppTheme.border, lineWidth: 1))
        }
    }

    private func tagChip(_ tag: StyleTag) -> some View {
        let isSelected = selection.contains(tag.name)
        return Button {
            toggle(tag.name)
        } label: {
            VStack(alignment: .leading, spacing: 2) {
                Text(tag.name)
                    .font(.callout.weight(.medium))
                Text(tag.category)
                    .font(.caption2.weight(.semibold))
                    .foregroundStyle(isSelected ? Color.white.opacity(0.72) : AppTheme.secondaryText)
            }
            .foregroundStyle(isSelected ? Color.white : Color.primary)
            .padding(.horizontal, 11)
            .padding(.vertical, 7)
            .background(isSelected ? AppTheme.accent : Color.white.opacity(0.06), in: RoundedRectangle(cornerRadius: 7, style: .continuous))
            .overlay(RoundedRectangle(cornerRadius: 7, style: .continuous).strokeBorder(isSelected ? AppTheme.accent.opacity(0.8) : AppTheme.border, lineWidth: 1))
        }
        .buttonStyle(.plain)
    }

    private func selectedChip(_ value: String) -> some View {
        Button {
            toggle(value)
        } label: {
            Text("\(value) x")
                .font(.caption.weight(.semibold))
                .foregroundStyle(Color.white)
                .padding(.horizontal, 9)
                .padding(.vertical, 5)
                .background(AppTheme.accent.opacity(0.8), in: Capsule())
        }
        .buttonStyle(.plain)
    }

    private func toggle(_ value: String) {
        if selection.contains(value) {
            selection.removeAll { $0 == value }
        } else {
            selection.append(value)
        }
    }
}

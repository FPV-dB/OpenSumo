import SwiftUI

struct MultiSelectChipView: View {
    let title: String
    let options: [String]
    @Binding var selection: [String]

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.headline)
            FlowLayout(spacing: 8) {
                ForEach(options, id: \.self) { option in
                    chip(option)
                }
            }
        }
    }

    private func chip(_ option: String) -> some View {
        let isSelected = selection.contains(option)
        return Button {
            if isSelected {
                selection.removeAll { $0 == option }
            } else {
                selection.append(option)
            }
        } label: {
            Text(option)
                .font(.callout.weight(.medium))
                .foregroundStyle(isSelected ? Color.white : AppTheme.secondaryText)
                .padding(.horizontal, 12)
                .padding(.vertical, 7)
                .background(isSelected ? AppTheme.accent : AppTheme.control, in: Capsule())
                .overlay(Capsule().strokeBorder(isSelected ? AppTheme.accent.opacity(0.8) : AppTheme.border, lineWidth: 1))
        }
        .buttonStyle(.plain)
    }
}

struct FlowLayout: Layout {
    var spacing: CGFloat = 8

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout Void) -> CGSize {
        let maxWidth = proposal.width ?? 600
        var size = CGSize.zero
        var rowWidth: CGFloat = 0
        var rowHeight: CGFloat = 0

        for subview in subviews {
            let child = subview.sizeThatFits(.unspecified)
            if rowWidth + child.width > maxWidth, rowWidth > 0 {
                size.width = max(size.width, rowWidth - spacing)
                size.height += rowHeight + spacing
                rowWidth = 0
                rowHeight = 0
            }
            rowWidth += child.width + spacing
            rowHeight = max(rowHeight, child.height)
        }

        size.width = max(size.width, rowWidth - spacing)
        size.height += rowHeight
        return size
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout Void) {
        var origin = bounds.origin
        var rowHeight: CGFloat = 0

        for subview in subviews {
            let child = subview.sizeThatFits(.unspecified)
            if origin.x + child.width > bounds.maxX, origin.x > bounds.minX {
                origin.x = bounds.minX
                origin.y += rowHeight + spacing
                rowHeight = 0
            }
            subview.place(at: origin, proposal: ProposedViewSize(child))
            origin.x += child.width + spacing
            rowHeight = max(rowHeight, child.height)
        }
    }
}

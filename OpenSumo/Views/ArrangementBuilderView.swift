import SwiftUI

struct ArrangementBuilderView: View {
    @ObservedObject var viewModel: PromptEditorViewModel
    @State private var pendingSection = "Verse"

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("Song Structure")
                .font(.headline)

            HStack {
                Picker("Section", selection: $pendingSection) {
                    ForEach(PromptOptions.arrangementSections, id: \.self) { section in
                        Text(section).tag(section)
                    }
                }
                Button("Add") {
                    viewModel.addArrangementSection(pendingSection)
                }
            }

            List {
                ForEach(Array(viewModel.currentPreset.arrangementSections.enumerated()), id: \.offset) { index, section in
                    HStack {
                        Text("\(index + 1)")
                            .font(.caption.monospacedDigit())
                            .foregroundStyle(AppTheme.secondaryText)
                            .frame(width: 24, alignment: .leading)
                        Text(section)
                        Spacer()
                    }
                    .padding(.vertical, 4)
                }
                .onDelete(perform: viewModel.removeArrangementSection)
                .onMove(perform: viewModel.moveArrangementSection)
            }
            .frame(minHeight: 180)
            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))

            Text("Use drag handles in the list to reorder sections.")
                .font(.caption)
                .foregroundStyle(AppTheme.secondaryText)
        }
    }
}

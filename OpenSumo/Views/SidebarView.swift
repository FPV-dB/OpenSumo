import SwiftUI

struct SidebarView: View {
    @ObservedObject var viewModel: PromptEditorViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            VStack(alignment: .leading, spacing: 4) {
                Text("OpenSumo")
                    .font(.largeTitle.weight(.bold))
                Text("AI music prompt studio")
                    .foregroundStyle(AppTheme.secondaryText)
            }
            .padding(.horizontal, 18)
            .padding(.top, 18)

            VStack(spacing: 8) {
                Button("New Prompt", action: viewModel.newPrompt)
                Button("Randomise Prompt", action: viewModel.randomisePrompt)
                Button("Save Preset", action: viewModel.savePreset)
                Button("Duplicate Preset", action: viewModel.duplicatePreset)
                Button("Delete Preset", role: .destructive, action: viewModel.deletePreset)
            }
            .buttonStyle(.bordered)
            .controlSize(.regular)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 18)

            sidebarSectionTitle("Presets")
            List(selection: $viewModel.selectedPresetID) {
                ForEach(viewModel.presets) { preset in
                    Text(preset.name)
                        .tag(Optional(preset.id))
                }
            }
            .onChange(of: viewModel.selectedPresetID) { _, id in
                if let id {
                    viewModel.selectPreset(id)
                }
            }
            .frame(minHeight: 210)

            sidebarSectionTitle("Sections")
            VStack(spacing: 4) {
                ForEach(PromptOptions.sections, id: \.self) { section in
                    Button {
                        viewModel.selectedSection = section
                    } label: {
                        HStack {
                            Text(section)
                            Spacer()
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(viewModel.selectedSection == section ? AppTheme.controlActive : Color.clear, in: RoundedRectangle(cornerRadius: 7, style: .continuous))
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal, 12)

            Spacer()
        }
        .background(AppTheme.sidebar)
    }

    private func sidebarSectionTitle(_ title: String) -> some View {
        Text(title.uppercased())
            .font(.caption.weight(.semibold))
            .foregroundStyle(AppTheme.secondaryText)
            .padding(.horizontal, 18)
    }
}

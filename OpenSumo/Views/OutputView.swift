import SwiftUI

struct OutputView: View {
    @ObservedObject var viewModel: PromptEditorViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            VStack(alignment: .leading, spacing: 4) {
                Text("Prompt Output")
                    .font(.title2.weight(.semibold))
                Text("Live copy-ready preview")
                    .foregroundStyle(AppTheme.secondaryText)
            }

            VStack(alignment: .leading, spacing: 12) {
                Text(viewModel.currentPreset.generatedPrompt)
                    .font(.system(.body, design: .serif))
                    .lineSpacing(5)
                    .textSelection(.enabled)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    .padding(14)
                    .background(AppTheme.output, in: RoundedRectangle(cornerRadius: 8, style: .continuous))
                    .overlay(RoundedRectangle(cornerRadius: 8, style: .continuous).strokeBorder(AppTheme.border, lineWidth: 1))
            }
            .frame(maxHeight: .infinity)

            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    stat("Words", "\(viewModel.wordCount)")
                    stat("Strength", viewModel.promptStrength.rawValue)
                }
                if let error = viewModel.storeError {
                    Text(error)
                        .font(.caption)
                        .foregroundStyle(.red)
                }
            }

            HStack {
                Button("Copy to Clipboard") {
                    viewModel.copyPromptToClipboard()
                }
                .keyboardShortcut("c", modifiers: [.command, .shift])

                Button("Regenerate Wording") {
                    viewModel.regenerateWording()
                }

                Button("Clear", role: .destructive) {
                    viewModel.clearPrompt()
                }
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
        }
        .padding(22)
        .background(AppTheme.detail)
    }

    private func stat(_ title: String, _ value: String) -> some View {
        VStack(alignment: .leading, spacing: 3) {
            Text(title.uppercased())
                .font(.caption2.weight(.bold))
                .foregroundStyle(AppTheme.secondaryText)
            Text(value)
                .font(.headline)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(10)
        .background(AppTheme.control, in: RoundedRectangle(cornerRadius: 8, style: .continuous))
    }
}

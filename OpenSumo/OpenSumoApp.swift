import SwiftUI

@main
struct OpenSumoApp: App {
    @StateObject private var viewModel = PromptEditorViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: viewModel)
                .preferredColorScheme(.dark)
                .frame(minWidth: 1180, minHeight: 760)
        }
        .windowStyle(.titleBar)
        .windowToolbarStyle(.unified)
        .commands {
            CommandGroup(replacing: .newItem) {
                Button("New Prompt") {
                    viewModel.newPrompt()
                }
                .keyboardShortcut("n", modifiers: .command)
            }
        }
    }
}

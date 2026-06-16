import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: PromptEditorViewModel

    var body: some View {
        NavigationSplitView {
            SidebarView(viewModel: viewModel)
                .navigationSplitViewColumnWidth(min: 240, ideal: 280, max: 320)
        } content: {
            EditorView(viewModel: viewModel)
                .navigationSplitViewColumnWidth(min: 520, ideal: 680, max: 860)
        } detail: {
            OutputView(viewModel: viewModel)
                .navigationSplitViewColumnWidth(min: 320, ideal: 400, max: 520)
        }
        .background(AppTheme.background)
    }
}

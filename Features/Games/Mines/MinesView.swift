// Stub generated for project scaffolding. Implement later.
import SwiftUI

struct MinesView: View {
    @Environment(AppModel.self) private var appModel
    @State private var viewModel: MinesViewModel?

    var body: some View {
        VStack(spacing: 24) {
            Text("Mines")
                .font(Typography.Token.heroMetric())
            Text("Game coming soon")
                .font(Typography.Token.secondary())
                .foregroundStyle(.secondary)
        }
        .onAppear {
            if viewModel == nil {
                viewModel = MinesViewModel(appModel: appModel)
            }
        }
        .navigationTitle("Mines")
    }
}

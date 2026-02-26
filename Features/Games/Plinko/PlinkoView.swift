// Stub generated for project scaffolding. Implement later.
import SwiftUI

struct PlinkoView: View {
    @Environment(AppModel.self) private var appModel
    @State private var viewModel: PlinkoViewModel?

    var body: some View {
        VStack(spacing: 24) {
            Text("Plinko")
                .font(Typography.Token.heroMetric())
            Text("Game coming soon")
                .font(Typography.Token.secondary())
                .foregroundStyle(.secondary)
        }
        .onAppear {
            if viewModel == nil {
                viewModel = PlinkoViewModel(appModel: appModel)
            }
        }
        .navigationTitle("Plinko")
    }
}

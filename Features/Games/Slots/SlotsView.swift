// Stub generated for project scaffolding. Implement later.
import SwiftUI

struct SlotsView: View {
    @Environment(AppModel.self) private var appModel
    @State private var viewModel: SlotsViewModel?

    var body: some View {
        VStack(spacing: 24) {
            Text("Slots")
                .font(Typography.Token.heroMetric())
            Text("Game coming soon")
                .font(Typography.Token.secondary())
                .foregroundStyle(.secondary)
        }
        .onAppear {
            if viewModel == nil {
                viewModel = SlotsViewModel(appModel: appModel)
            }
        }
        .navigationTitle("Slots")
    }
}

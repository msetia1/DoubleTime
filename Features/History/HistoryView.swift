// Stub generated for project scaffolding. Implement later.
import SwiftUI

struct HistoryView: View {
    @Environment(AppModel.self) private var appModel
    @State private var viewModel: HistoryViewModel?

    var body: some View {
        VStack(spacing: 24) {
            Text("History")
                .font(Typography.Token.heroMetric())
            Text("Your game transaction history")
                .font(Typography.Token.secondary())
                .foregroundStyle(.secondary)
        }
        .onAppear {
            if viewModel == nil {
                viewModel = HistoryViewModel(appModel: appModel)
            }
        }
        .navigationTitle("History")
    }
}

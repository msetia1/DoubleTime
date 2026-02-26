// Stub generated for project scaffolding. Implement later.
import SwiftUI

struct CrashView: View {
    @Environment(AppModel.self) private var appModel
    @State private var viewModel: CrashViewModel?

    var body: some View {
        VStack(spacing: 24) {
            Text("Crash")
                .font(Typography.Token.heroMetric())
            Text("Game coming soon")
                .font(Typography.Token.secondary())
                .foregroundStyle(.secondary)
        }
        .onAppear {
            if viewModel == nil {
                viewModel = CrashViewModel(appModel: appModel)
            }
        }
        .navigationTitle("Crash")
    }
}

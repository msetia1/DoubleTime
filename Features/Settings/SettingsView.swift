// Stub generated for project scaffolding. Implement later.
import SwiftUI

struct SettingsView: View {
    @Environment(AppModel.self) private var appModel
    @State private var viewModel: SettingsViewModel?

    var body: some View {
        VStack(spacing: 24) {
            Text("Settings")
                .font(Typography.Token.heroMetric())
            Text("Configure your daily allowance and app selection")
                .font(Typography.Token.secondary())
                .foregroundStyle(.secondary)
        }
        .onAppear {
            if viewModel == nil {
                viewModel = SettingsViewModel(appModel: appModel)
            }
        }
        .navigationTitle("Options")
    }
}

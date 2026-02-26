// Stub generated for project scaffolding. Implement later.
import SwiftUI

struct OnboardingView: View {
    @Environment(AppModel.self) private var appModel
    @State private var viewModel: OnboardingViewModel?

    var body: some View {
        VStack(spacing: 24) {
            Text("Onboarding")
                .font(Typography.Token.heroMetric())
            Text("Welcome to DoubleTime")
                .font(Typography.Token.secondary())
                .foregroundStyle(.secondary)
        }
        .onAppear {
            if viewModel == nil {
                viewModel = OnboardingViewModel(appModel: appModel)
            }
        }
        .navigationTitle("Welcome")
    }
}

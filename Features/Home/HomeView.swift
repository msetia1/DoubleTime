import SwiftUI

/// Home screen: shows the remaining-minutes hero surface and pull-to-refresh.
///
/// Per data_flow.md Sequence 3, pull-to-refresh triggers a usage refresh
/// through the ViewModel → AppModel coordinator path.
struct HomeView: View {

    @Environment(AppModel.self) private var appModel
    @State private var viewModel: HomeViewModel?

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {

                // MARK: Hero Card
                RemainingMinutesCard(
                    remainingMinutes: resolvedViewModel.remainingMinutes,
                    dailyAllowanceMinutes: resolvedViewModel.dailyAllowanceMinutes,
                    bonusMinutesFromGames: resolvedViewModel.bonusMinutesFromGames,
                    usageMinutesToday: resolvedViewModel.usageMinutesToday
                )
                .padding(.horizontal, 16)
                .padding(.top, 24)

                // MARK: Last Refresh
                if let lastRefresh = resolvedViewModel.lastRefreshDate {
                    Text("Updated \(lastRefresh, format: .relative(presentation: .named))")
                        .font(Typography.Token.caption())
                        .foregroundStyle(.tertiary)
                }

                Spacer(minLength: 0)
            }
        }
        .refreshable {
            await resolvedViewModel.refresh()
        }
        .onAppear {
            if viewModel == nil {
                viewModel = HomeViewModel(appModel: appModel)
            }
        }
        .navigationTitle("Home")
        .navigationBarTitleDisplayMode(.large)
    }

    /// Lazily resolved ViewModel. Falls back to creating one inline if needed
    /// (should not happen in practice because `onAppear` fires first).
    private var resolvedViewModel: HomeViewModel {
        viewModel ?? HomeViewModel(appModel: appModel)
    }
}

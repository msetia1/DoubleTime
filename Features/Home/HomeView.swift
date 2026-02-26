import SwiftUI

/// Home screen: shows the remaining-minutes hero surface and pull-to-refresh.
///
/// Per data_flow.md Sequence 3, pull-to-refresh triggers a usage refresh
/// through the ViewModel → AppModel coordinator path.
struct HomeView: View {

    @Environment(AppModel.self) private var appModel
    @State private var viewModel: HomeViewModel?
    @State private var selectedWagerPreset: Int?

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

                // MARK: Shared Wager Chips (used by future game screens)
                CardContainer {
                    WagerChips(
                        maxWagerMinutes: max(0, resolvedViewModel.remainingMinutes),
                        currentRemainingMinutes: resolvedViewModel.remainingMinutes,
                        selectedMinutes: selectedWagerPreset
                    ) { selected in
                        selectedWagerPreset = selected
                    }
                }
                .padding(.horizontal, 16)

                // MARK: Last Refresh
                if let lastRefresh = resolvedViewModel.lastRefreshDate {
                    Text("Updated \(lastRefresh, format: .relative(presentation: .named))")
                        .font(Typography.Token.caption())
                        .foregroundStyle(.tertiary)
                }

                Spacer(minLength: 0)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .refreshable {
            await resolvedViewModel.refresh()
        }
        .onAppear {
            if viewModel == nil {
                viewModel = HomeViewModel(appModel: appModel)
            }
            if selectedWagerPreset == nil {
                selectedWagerPreset = max(1, min(5, resolvedViewModel.remainingMinutes))
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

import SwiftUI

/// Thin orchestration layer for the Home screen.
///
/// All state lives in the global models (`AppModel`); this ViewModel
/// exists to coordinate UI actions (e.g. pull-to-refresh, lock toggle)
/// without exposing service calls directly to the View.
@Observable
final class HomeViewModel {

    // MARK: - Dependencies

    private let appModel: AppModel

    init(appModel: AppModel) {
        self.appModel = appModel
    }

    // MARK: - Derived Convenience

    var remainingMinutes: Int { appModel.remainingMinutes }

    var dailyAllowanceMinutes: Int { appModel.timeBudget.dailyAllowanceMinutes }
    var bonusMinutesFromGames: Int { appModel.timeBudget.bonusMinutesFromGames }
    var usageMinutesToday: Int { appModel.usage.usageMinutesToday }

    var isLocked: Bool {
        !appModel.lockState.isUnlockedEffective(remainingMinutes: appModel.remainingMinutes)
    }

    var unlockAllowed: Bool {
        appModel.lockState.unlockAllowed(remainingMinutes: appModel.remainingMinutes)
    }

    var lastRefreshDate: Date? { appModel.usage.lastUsageRefreshDate }

    // MARK: - Actions

    /// Pull-to-refresh trigger (Sequence 3: Manual Pull-to-Refresh on Home).
    func refresh() async {
        await appModel.refreshUsageAndRecomputeRemaining()
    }

    /// Lock toggle (delegates to AppModel). Returns whether toggle succeeded.
    @discardableResult
    func toggleLock() async -> Bool {
        await appModel.toggleLock()
    }
}

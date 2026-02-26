import SwiftUI
import UIKit

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

    // MARK: - UI State

    /// Controls InlineStatusMessage visibility when unlock is blocked.
    var showBlockedMessage: Bool = false

    /// Toggled to trigger the shake animation on the lock button.
    var shakeToggle: Bool = false

    // MARK: - Actions

    /// Pull-to-refresh trigger (Sequence 3: Manual Pull-to-Refresh on Home).
    func refresh() async {
        await appModel.refreshUsageAndRecomputeRemaining()
    }

    /// Lock toggle with haptic feedback.
    ///
    /// When unlock is blocked (0 minutes), fires shake + inline message
    /// instead of toggling state.
    @discardableResult
    func toggleLock() async -> Bool {
        if !unlockAllowed && isLocked {
            // Blocked — fire UI feedback only
            shakeToggle.toggle()
            showBlockedMessage = true
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.warning)
            return false
        }

        let wasLocked = isLocked
        let success = await appModel.toggleLock()

        if success {
            if wasLocked {
                // Unlocked successfully
                let generator = UINotificationFeedbackGenerator()
                generator.notificationOccurred(.success)
            } else {
                // Locked successfully
                let generator = UIImpactFeedbackGenerator(style: .light)
                generator.impactOccurred()
            }
        }

        return success
    }
}

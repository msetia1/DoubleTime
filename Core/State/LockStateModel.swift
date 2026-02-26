import Foundation

@Observable
final class LockStateModel {
    var userWantsUnlocked: Bool = false

    /// Whether unlocking is allowed based on remaining minutes.
    func unlockAllowed(remainingMinutes: Int) -> Bool {
        remainingMinutes > 0
    }

    /// Whether the apps are effectively unlocked right now.
    func isUnlockedEffective(remainingMinutes: Int) -> Bool {
        userWantsUnlocked && unlockAllowed(remainingMinutes: remainingMinutes)
    }
}

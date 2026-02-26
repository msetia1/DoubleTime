import Foundation

@Observable
final class AppModel {
    let timeBudget = TimeBudgetModel()
    let usage = UsageModel()
    let lockState = LockStateModel()
    let transactions = TransactionsModel()

    /// The single primary user-facing value. Computed, never stored.
    var remainingMinutes: Int {
        RemainingMinutesCalculator.calculate(
            dailyAllowanceMinutes: timeBudget.dailyAllowanceMinutes,
            bonusMinutesFromGames: timeBudget.bonusMinutesFromGames,
            usageMinutesToday: usage.usageMinutesToday
        )
    }

    // MARK: - Services

    private let shieldService = ShieldService()
    private let usageService = DeviceActivityUsageService()
    private let selectionService = AppSelectionService()

    // MARK: - Persistence

    private let store: KeyValueStore

    init(store: KeyValueStore = UserDefaultsStore()) {
        self.store = store
        loadPersistedState()
        handlePendingWagerForfeit()
    }

    // MARK: - Day Reset

    /// Checks if a new day has started and resets per-day values.
    func checkDayReset() {
        let today = DateKey.today()
        let lastDay = store.string(forKey: Keys.lastDayKey) ?? ""
        if today != lastDay {
            timeBudget.bonusMinutesFromGames = 0
            usage.usageMinutesToday = 0
            store.set(today, forKey: Keys.lastDayKey)
            save()
        }
    }

    // MARK: - Shield Policy

    /// Applies or clears shields based on lock state and remaining minutes.
    func enforceShieldPolicy() {
        let tokens = selectionService.applicationTokens
        guard !tokens.isEmpty else { return }

        if lockState.isUnlockedEffective(remainingMinutes: remainingMinutes) {
            shieldService.clearShields()
        } else {
            shieldService.applyShields(for: tokens)
        }
    }

    // MARK: - Usage Refresh

    /// Fetches latest usage from Screen Time, recomputes remaining, and enforces shields.
    func refreshUsageAndRecomputeRemaining() async {
        let tokens = selectionService.applicationTokens
        let mins = await usageService.fetchUsageMinutesToday(for: tokens)
        usage.usageMinutesToday = mins
        usage.lastUsageRefreshDate = Date()
        enforceShieldPolicy()
        save()
    }

    // MARK: - Lock Toggle

    /// Toggles the lock state. Returns true if the toggle succeeded.
    @discardableResult
    func toggleLock() async -> Bool {
        await refreshUsageAndRecomputeRemaining()

        if lockState.userWantsUnlocked {
            // Currently unlocked → lock
            lockState.userWantsUnlocked = false
        } else {
            // Currently locked → try to unlock
            guard lockState.unlockAllowed(remainingMinutes: remainingMinutes) else {
                return false
            }
            lockState.userWantsUnlocked = true
        }

        enforceShieldPolicy()
        save()
        return true
    }

    // MARK: - Game Wager Lifecycle

    /// Persists a pending wager when a game starts.
    func setPendingWager(gameType: GameType, wagerMinutes: Int) {
        let pending = PendingWager(gameType: gameType, wagerMinutes: wagerMinutes)
        store.setCodable(pending, forKey: Keys.pendingWager)
    }

    /// Clears the pending wager after successful game resolution.
    func clearPendingWager() {
        store.remove(forKey: Keys.pendingWager)
    }

    /// Applies a game result: updates bonus, appends transaction, clears pending wager.
    func applyGameResult(gameType: GameType, wagerMinutes: Int, deltaMinutes: Int, multiplier: Double) {
        timeBudget.bonusMinutesFromGames += deltaMinutes
        let transaction = GameTransaction(
            gameType: gameType,
            wagerMinutes: wagerMinutes,
            deltaMinutes: deltaMinutes,
            multiplier: multiplier
        )
        transactions.append(transaction)
        clearPendingWager()
        enforceShieldPolicy()
        save()
    }

    // MARK: - Persistence Helpers

    func save() {
        store.set(timeBudget.dailyAllowanceMinutes, forKey: Keys.dailyAllowance)
        store.set(timeBudget.bonusMinutesFromGames, forKey: Keys.bonus)
        store.set(lockState.userWantsUnlocked, forKey: Keys.userWantsUnlocked)
        store.setCodable(transactions.transactions, forKey: Keys.transactions)
    }

    private func loadPersistedState() {
        if let allowance = store.integer(forKey: Keys.dailyAllowance) {
            timeBudget.dailyAllowanceMinutes = allowance
        }
        if let bonus = store.integer(forKey: Keys.bonus) {
            timeBudget.bonusMinutesFromGames = bonus
        }
        lockState.userWantsUnlocked = store.bool(forKey: Keys.userWantsUnlocked)
        if let saved: [GameTransaction] = store.codable(forKey: Keys.transactions) {
            for t in saved { transactions.append(t) }
        }
    }

    private func handlePendingWagerForfeit() {
        guard let pending: PendingWager = store.codable(forKey: Keys.pendingWager) else { return }
        let forfeitDelta = -pending.wagerMinutes
        timeBudget.bonusMinutesFromGames += forfeitDelta
        let transaction = GameTransaction(
            gameType: pending.gameType,
            wagerMinutes: pending.wagerMinutes,
            deltaMinutes: forfeitDelta,
            multiplier: 0
        )
        transactions.append(transaction)
        clearPendingWager()
        save()
    }
}

// MARK: - Supporting Types

private struct PendingWager: Codable {
    let gameType: GameType
    let wagerMinutes: Int
}

private enum Keys {
    static let dailyAllowance = "dailyAllowanceMinutes"
    static let bonus = "bonusMinutesFromGames"
    static let userWantsUnlocked = "userWantsUnlocked"
    static let transactions = "transactions"
    static let pendingWager = "pendingWager"
    static let lastDayKey = "lastDayKey"
}

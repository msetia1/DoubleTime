import Foundation

final class CrashEngine: GameEngine {

    // MARK: - GameEngine Protocol (no cashout = loss)

    func resolve(wagerMinutes: Int) -> GameOutcome {
        GameOutcome(deltaMinutes: -wagerMinutes, multiplier: 0)
    }

    // MARK: - Crash-Specific

    /// Generates a crash point using the spec formula.
    /// Distribution: ~1% instant crash at 1.00x, ~50% at or below 2.00x,
    /// ~80% at or below 5.00x, ~90% at or below 10.00x. House edge ~1%.
    func generateCrashPoint() -> Double {
        let r = RNG.uniform()
        let raw = 0.99 / (1.0 - r)
        return max(1.00, floor(raw * 100.0) / 100.0)
    }

    /// Resolves a round given the player's cashout multiplier and the crash point.
    /// Cashout must be strictly less than crash point to win.
    func resolve(wagerMinutes: Int, cashoutMultiplier: Double, crashPoint: Double) -> GameOutcome {
        if cashoutMultiplier >= crashPoint {
            // Crashed before or at cashout — loss
            return GameOutcome(deltaMinutes: -wagerMinutes, multiplier: crashPoint)
        }
        // Cashed out successfully
        let payout = Int(floor(Double(wagerMinutes) * cashoutMultiplier))
        let delta = payout - wagerMinutes
        return GameOutcome(deltaMinutes: delta, multiplier: cashoutMultiplier)
    }
}

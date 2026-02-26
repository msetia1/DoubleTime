import Foundation

enum RemainingMinutesCalculator {
    /// Computes remaining minutes from the three input values.
    /// Result is clamped to a minimum of 0.
    ///
    /// Formula: max(0, (dailyAllowance + bonus) - usage)
    static func calculate(
        dailyAllowanceMinutes: Int,
        bonusMinutesFromGames: Int,
        usageMinutesToday: Int
    ) -> Int {
        max(0, (dailyAllowanceMinutes + bonusMinutesFromGames) - usageMinutesToday)
    }
}

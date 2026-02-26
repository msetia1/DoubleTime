import Foundation

enum WagerPreviewCalculator {
    /// Computes the delta minutes for a given wager and multiplier.
    /// Uses floor rounding per spec.
    static func deltaMinutes(wagerMinutes: Int, multiplier: Double) -> Int {
        let payout = Int(floor(Double(wagerMinutes) * multiplier))
        return payout - wagerMinutes
    }

    /// Computes delta minutes with the payout cap applied.
    /// Ensures remainingMinutes never exceeds minutesUntilMidnight.
    static func cappedDeltaMinutes(
        wagerMinutes: Int,
        multiplier: Double,
        currentRemainingMinutes: Int,
        minutesUntilMidnight: Int
    ) -> Int {
        let rawDelta = deltaMinutes(wagerMinutes: wagerMinutes, multiplier: multiplier)

        // Losses are never capped
        if rawDelta <= 0 { return rawDelta }

        let maxDelta = minutesUntilMidnight - currentRemainingMinutes
        return min(rawDelta, max(0, maxDelta))
    }

    /// Returns the minutes remaining until 23:59 today.
    static func minutesUntilMidnight(from date: Date = Date()) -> Int {
        let calendar = Calendar.current
        let endOfDay = calendar.startOfDay(for: date).addingTimeInterval(23 * 3600 + 59 * 60)
        let seconds = endOfDay.timeIntervalSince(date)
        return max(0, Int(floor(seconds / 60.0)))
    }
}

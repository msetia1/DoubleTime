import Foundation

@Observable
final class TimeBudgetModel {
    var dailyAllowanceMinutes: Int = 60
    var bonusMinutesFromGames: Int = 0
}

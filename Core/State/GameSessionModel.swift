import Foundation

@Observable
final class GameSessionModel {
    var currentGame: GameType?
    var currentWagerMinutes: Int = 0
    var wagerPlacedAt: Date?

    var hasActiveWager: Bool {
        currentGame != nil && currentWagerMinutes > 0 && wagerPlacedAt != nil
    }

    func placeWager(game: GameType, minutes: Int) {
        currentGame = game
        currentWagerMinutes = minutes
        wagerPlacedAt = Date()
    }

    func clearWager() {
        currentGame = nil
        currentWagerMinutes = 0
        wagerPlacedAt = nil
    }
}

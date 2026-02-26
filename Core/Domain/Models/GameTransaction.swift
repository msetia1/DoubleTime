import Foundation

struct GameTransaction: Codable, Identifiable {
    let id: UUID
    let gameType: GameType
    let wagerMinutes: Int
    let deltaMinutes: Int
    let multiplier: Double
    let timestamp: Date

    init(
        id: UUID = UUID(),
        gameType: GameType,
        wagerMinutes: Int,
        deltaMinutes: Int,
        multiplier: Double,
        timestamp: Date = Date()
    ) {
        self.id = id
        self.gameType = gameType
        self.wagerMinutes = wagerMinutes
        self.deltaMinutes = deltaMinutes
        self.multiplier = multiplier
        self.timestamp = timestamp
    }
}

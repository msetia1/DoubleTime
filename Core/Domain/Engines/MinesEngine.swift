import Foundation

enum MinesEngine {
    static let gridSize = 25
    static let rows = 5
    static let cols = 5

    // MARK: - Multiplier Table

    /// Pre-computed multiplier with 1% house edge: 0.99 × C(25,d) / C(25−m,d)
    static func multiplier(mineCount: Int, safeReveals: Int) -> Double {
        guard safeReveals > 0,
              mineCount >= 1, mineCount <= 24,
              safeReveals <= maxSafeReveals(mineCount: mineCount) else { return 1.0 }
        var result = 0.99
        for i in 0..<safeReveals {
            result *= Double(gridSize - i) / Double(gridSize - mineCount - i)
        }
        return (result * 100).rounded() / 100
    }

    static func maxSafeReveals(mineCount: Int) -> Int {
        gridSize - mineCount
    }

    // MARK: - Board Generation

    static func generateBoard(mineCount: Int) -> [Bool] {
        var isMine = Array(repeating: true, count: mineCount)
            + Array(repeating: false, count: gridSize - mineCount)
        isMine.shuffle()
        return isMine
    }

    // MARK: - Delta

    static func cashoutDelta(wagerMinutes: Int, multiplier: Double) -> Int {
        Int(floor(Double(wagerMinutes) * (multiplier - 1.0)))
    }
}

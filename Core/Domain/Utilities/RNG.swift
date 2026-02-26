import Foundation

enum RNG {
    /// Returns a uniform random Double in [0, 1).
    static func uniform() -> Double {
        Double.random(in: 0.0 ..< 1.0)
    }

    /// Returns a random Int in the given range (inclusive).
    static func randomInt(in range: ClosedRange<Int>) -> Int {
        Int.random(in: range)
    }

    /// Returns a random Bool (50/50 coin flip).
    static func coinFlip() -> Bool {
        Bool.random()
    }
}

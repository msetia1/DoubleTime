// Stub generated for project scaffolding. Implement later.
import Foundation

struct GameOutcome {
    let deltaMinutes: Int
    let multiplier: Double
}

protocol GameEngine {
    func resolve(wagerMinutes: Int) -> GameOutcome
}

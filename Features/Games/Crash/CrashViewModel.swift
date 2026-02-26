import SwiftUI
import UIKit

enum CrashPhase {
    case idle       // Wager placed, waiting for "Launch"
    case running    // Multiplier climbing
    case crashed    // Hit crash point — loss
    case cashedOut  // Player cashed out — win
}

@Observable
final class CrashViewModel {

    // MARK: - Dependencies

    private let appModel: AppModel
    private let engine = CrashEngine()

    init(appModel: AppModel) {
        self.appModel = appModel
    }

    // MARK: - Game State

    private(set) var phase: CrashPhase = .idle
    private(set) var displayMultiplier: Double = 1.00
    private(set) var lastOutcome: GameOutcome?
    private(set) var wagerMinutes: Int = 0
    var errorMessage: String?

    private var crashPoint: Double = 1.00
    private var gameStartTime: Date?
    private var tickTask: Task<Void, Never>?

    // Exponential growth rate: 2x at ~8.7s, 5x at ~20s, 10x at ~29s
    private let speed: Double = 0.08

    // MARK: - Computed

    var formattedMultiplier: String {
        String(format: "%.2fx", displayMultiplier)
    }

    var outcomeText: String? {
        guard let outcome = lastOutcome else { return nil }
        let prefix = outcome.deltaMinutes >= 0 ? "+" : ""
        return "\(prefix)\(outcome.deltaMinutes) min"
    }

    // MARK: - Lifecycle

    /// Player taps "Launch" — validates wager, generates crash point, starts the round.
    func startGame(wagerMinutes: Int) {
        do {
            try appModel.setPendingWager(gameType: .crash, wagerMinutes: wagerMinutes)
        } catch {
            errorMessage = "Not enough minutes"
            return
        }

        self.wagerMinutes = wagerMinutes
        crashPoint = engine.generateCrashPoint()
        displayMultiplier = 1.00
        lastOutcome = nil
        errorMessage = nil
        phase = .running

        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()

        startTickLoop()
    }

    /// Player taps "Cash Out" — locks in current multiplier as a win.
    func cashOut() {
        guard phase == .running else { return }
        stopTickLoop()

        let rawOutcome = engine.resolve(
            wagerMinutes: wagerMinutes,
            cashoutMultiplier: displayMultiplier,
            crashPoint: crashPoint
        )

        let cappedDelta = WagerPreviewCalculator.cappedDeltaMinutes(
            wagerMinutes: wagerMinutes,
            multiplier: displayMultiplier,
            currentRemainingMinutes: appModel.remainingMinutes,
            minutesUntilMidnight: WagerPreviewCalculator.minutesUntilMidnight()
        )

        let finalOutcome = GameOutcome(deltaMinutes: cappedDelta, multiplier: rawOutcome.multiplier)
        lastOutcome = finalOutcome
        phase = .cashedOut

        appModel.applyGameResult(
            gameType: .crash,
            wagerMinutes: wagerMinutes,
            deltaMinutes: cappedDelta,
            multiplier: displayMultiplier
        )

        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }

    /// Resets state for a new round.
    func resetForNewRound() {
        stopTickLoop()
        phase = .idle
        displayMultiplier = 1.00
        crashPoint = 1.00
        lastOutcome = nil
        wagerMinutes = 0
        errorMessage = nil
    }

    // MARK: - Internal

    /// Called when the multiplier reaches the crash point — loss.
    private func handleCrash() {
        stopTickLoop()
        displayMultiplier = crashPoint

        let outcome = GameOutcome(deltaMinutes: -wagerMinutes, multiplier: 0)
        lastOutcome = outcome
        phase = .crashed

        appModel.applyGameResult(
            gameType: .crash,
            wagerMinutes: wagerMinutes,
            deltaMinutes: -wagerMinutes,
            multiplier: 0
        )

        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.warning)
    }

    // MARK: - Tick Loop

    private func startTickLoop() {
        gameStartTime = Date()
        tickTask = Task { @MainActor [weak self] in
            guard let self else { return }
            while !Task.isCancelled && self.phase == .running {
                let elapsed = Date().timeIntervalSince(self.gameStartTime ?? Date())
                let newMultiplier = exp(self.speed * elapsed)
                let rounded = floor(newMultiplier * 100.0) / 100.0

                if rounded >= self.crashPoint {
                    self.handleCrash()
                    return
                }

                self.displayMultiplier = rounded
                try? await Task.sleep(for: .milliseconds(33))
            }
        }
    }

    private func stopTickLoop() {
        tickTask?.cancel()
        tickTask = nil
    }
}

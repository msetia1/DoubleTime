import SwiftUI
@preconcurrency import UIKit

// MARK: - Supporting Types

struct MineTile: Identifiable {
    let id: Int
    let isMine: Bool
    var isRevealed: Bool = false
}

enum MinesPhase: Equatable {
    case idle
    case ready
    case playing
    case ended
}

// MARK: - ViewModel

@MainActor @Observable
final class MinesViewModel {

    private let appModel: AppModel

    // MARK: Config (locked once playing)

    var mineCount: Int = 3

    // MARK: Round State

    var phase: MinesPhase = .idle
    var grid: [MineTile] = []
    var safeReveals: Int = 0
    var didHitMine: Bool = false
    var resultDelta: Int?
    var wagerMinutes: Int = 0

    // MARK: Derived

    var currentMultiplier: Double {
        MinesEngine.multiplier(mineCount: mineCount, safeReveals: safeReveals)
    }

    var maxSafeTiles: Int {
        MinesEngine.maxSafeReveals(mineCount: mineCount)
    }

    var canStart: Bool {
        wagerMinutes > 0 && phase == .ready
    }

    var canCashOut: Bool {
        safeReveals > 0 && phase == .playing
    }

    var cashoutDeltaMinutes: Int {
        MinesEngine.cashoutDelta(wagerMinutes: wagerMinutes, multiplier: currentMultiplier)
    }

    // MARK: Init

    init(appModel: AppModel) {
        self.appModel = appModel
    }

    // MARK: - Actions

    func onWagerPlaced(minutes: Int) {
        wagerMinutes = minutes
        phase = .ready
    }

    func startGame() {
        guard wagerMinutes > 0 else { return }
        do {
            try appModel.setPendingWager(gameType: .mines, wagerMinutes: wagerMinutes)
        } catch {
            return
        }

        let minePositions = MinesEngine.generateBoard(mineCount: mineCount)
        grid = minePositions.enumerated().map { MineTile(id: $0.offset, isMine: $0.element) }
        safeReveals = 0
        didHitMine = false
        resultDelta = nil
        phase = .playing
    }

    func revealTile(at index: Int) {
        guard phase == .playing,
              index >= 0, index < grid.count,
              !grid[index].isRevealed else { return }

        grid[index].isRevealed = true

        if grid[index].isMine {
            handleMineHit()
        } else {
            handleSafeReveal()
        }
    }

    func cashOut() {
        guard canCashOut else { return }
        performCashOut()
    }

    func endRound() {
        grid = []
        safeReveals = 0
        didHitMine = false
        resultDelta = nil
        wagerMinutes = 0
        phase = .idle
    }

    // MARK: - Internal

    private func handleMineHit() {
        didHitMine = true
        revealAll()
        let delta = -wagerMinutes
        appModel.applyGameResult(
            gameType: .mines,
            wagerMinutes: wagerMinutes,
            deltaMinutes: delta,
            multiplier: 0
        )
        resultDelta = delta
        phase = .ended

        UINotificationFeedbackGenerator().notificationOccurred(.error)
    }

    private func handleSafeReveal() {
        safeReveals += 1
        UIImpactFeedbackGenerator(style: .light).impactOccurred()

        if safeReveals >= maxSafeTiles {
            performCashOut()
        }
    }

    private func performCashOut() {
        revealAll()
        let delta = cashoutDeltaMinutes
        appModel.applyGameResult(
            gameType: .mines,
            wagerMinutes: wagerMinutes,
            deltaMinutes: delta,
            multiplier: currentMultiplier
        )
        resultDelta = delta
        phase = .ended

        UINotificationFeedbackGenerator().notificationOccurred(.success)
    }

    private func revealAll() {
        for i in grid.indices {
            grid[i].isRevealed = true
        }
    }
}

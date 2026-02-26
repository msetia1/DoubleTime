import SwiftUI

struct MinesView: View {
    @Environment(AppModel.self) private var appModel
    @Environment(GameSessionModel.self) private var gameSession
    @State private var viewModel: MinesViewModel?

    var body: some View {
        Group {
            if let viewModel {
                MinesContent(viewModel: viewModel)
            } else {
                Color.clear
            }
        }
        .onAppear {
            if viewModel == nil {
                viewModel = MinesViewModel(appModel: appModel)
            }
            if gameSession.hasActiveWager, let vm = viewModel, vm.phase == .idle {
                vm.onWagerPlaced(minutes: gameSession.currentWagerMinutes)
            }
        }
        .onChange(of: gameSession.currentWagerMinutes) { _, minutes in
            if minutes > 0 {
                viewModel?.onWagerPlaced(minutes: minutes)
            }
        }
        .navigationTitle("Mines")
    }
}

// MARK: - Content

private struct MinesContent: View {
    @Bindable var viewModel: MinesViewModel
    @Environment(GameSessionModel.self) private var gameSession

    var body: some View {
        VStack(spacing: 16) {
            switch viewModel.phase {
            case .idle:
                Spacer()
                Text("Place a wager to begin")
                    .font(Typography.Token.secondary())
                    .foregroundStyle(.secondary)
                Spacer()

            case .ready:
                Spacer()
                preGameControls
                Spacer()

            case .playing:
                gridView
                feedbackLine
                cashOutButton

            case .ended:
                gridView
                endedControls
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .animation(.easeInOut(duration: 0.25), value: viewModel.phase)
    }

    // MARK: - Pre-Game

    private var preGameControls: some View {
        VStack(spacing: 24) {
            mineCountPicker

            Button("Start Game") {
                viewModel.startGame()
            }
            .buttonStyle(BrandedActionButtonStyle(
                state: viewModel.canStart ? .primary : .disabled
            ))
            .disabled(!viewModel.canStart)
        }
    }

    private func resultBanner(delta: Int) -> some View {
        Text(delta >= 0 ? "+\(delta) min" : "−\(abs(delta)) min")
            .font(Typography.Token.heroMetric(size: 36))
            .foregroundStyle(delta >= 0 ? BrandPalette.accentEnd : .red)
            .frame(maxWidth: .infinity, alignment: .center)
    }

    private var mineCountPicker: some View {
        HStack {
            Text("Mines")
                .font(Typography.Token.secondary())
            Spacer()
            HStack(spacing: 12) {
                Button {
                    if viewModel.mineCount > 1 { viewModel.mineCount -= 1 }
                } label: {
                    Image(systemName: "minus.circle.fill")
                        .font(.title2)
                        .foregroundStyle(.secondary)
                }

                Text("\(viewModel.mineCount)")
                    .font(Typography.Token.controlLabel())
                    .frame(minWidth: 32)

                Button {
                    if viewModel.mineCount < 24 { viewModel.mineCount += 1 }
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .font(.title2)
                        .foregroundStyle(BrandPalette.accentEnd)
                }
            }
        }
        .padding(.horizontal, 8)
    }

    // MARK: - Grid

    private var gridView: some View {
        let columns = Array(repeating: GridItem(.flexible(), spacing: 8), count: MinesEngine.cols)

        return LazyVGrid(columns: columns, spacing: 8) {
            ForEach(viewModel.grid) { tile in
                TileCell(tile: tile, didHitMine: viewModel.didHitMine) {
                    viewModel.revealTile(at: tile.id)
                }
            }
        }
    }

    // MARK: - In-Round Feedback

    private var feedbackLine: some View {
        HStack(spacing: 6) {
            Text("Multiplier: \(viewModel.currentMultiplier, specifier: "%.2f")x")
                .font(Typography.Token.outcome())
                .fontWeight(.bold)
                .foregroundStyle(BrandPalette.accentEnd)
            Text("|")
                .font(Typography.Token.secondary())
                .foregroundStyle(.secondary)
            Text("Cashout: +\(viewModel.cashoutDeltaMinutes) min")
                .font(Typography.Token.secondary())
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .padding(.top, 4)
    }

    // MARK: - Cash Out

    private var cashOutButton: some View {
        Button("Cash Out") {
            viewModel.cashOut()
        }
        .buttonStyle(BrandedActionButtonStyle(
            state: viewModel.canCashOut ? .primary : .disabled
        ))
        .disabled(!viewModel.canCashOut)
    }

    // MARK: - Ended

    private var endedControls: some View {
        VStack(spacing: 16) {
            if let delta = viewModel.resultDelta {
                resultBanner(delta: delta)
            }

            Button("Play Again") {
                viewModel.endRound()
                gameSession.clearWager()
            }
            .buttonStyle(BrandedActionButtonStyle(state: .primary))
        }
    }
}

// MARK: - Tile Cell

private struct TileCell: View {
    let tile: MineTile
    let didHitMine: Bool
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            ZStack {
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(backgroundColor)
                    .aspectRatio(1, contentMode: .fit)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .strokeBorder(borderColor, lineWidth: 1.5)
                    )

                if tile.isRevealed {
                    Image(systemName: tile.isMine ? "bomb.fill" : "diamond.fill")
                        .font(.title2)
                        .foregroundStyle(tile.isMine ? .red : BrandPalette.accentEnd)
                        .transition(.scale.combined(with: .opacity))
                }
            }
        }
        .disabled(tile.isRevealed)
        .animation(.easeOut(duration: 0.18), value: tile.isRevealed)
    }

    private var backgroundColor: Color {
        guard tile.isRevealed else {
            return Color(.tertiarySystemBackground)
        }
        return tile.isMine
            ? Color.red.opacity(0.12)
            : BrandPalette.accentEnd.opacity(0.10)
    }

    private var borderColor: Color {
        guard tile.isRevealed else {
            return Color(.separator)
        }
        return tile.isMine ? .red.opacity(0.35) : BrandPalette.accentEnd.opacity(0.30)
    }
}

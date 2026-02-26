import SwiftUI

struct PlayContainerView: View {
    @Environment(AppModel.self) private var appModel
    @State private var selectedGame: GameType = .crash
    @State private var gameSession = GameSessionModel()
    @State private var showWagerModal = false
    @State private var showConfirmation = false
    @State private var confirmationOpacity: Double = 0

    var body: some View {
        ZStack {
            TabView(selection: $selectedGame) {
                ForEach(GameType.allCases, id: \.self) { game in
                    gameView(for: game)
                        .tag(game)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .always))

            if showConfirmation {
                VStack {
                    Spacer()
                    Text("Wager placed: \(gameSession.currentWagerMinutes) min")
                        .font(Typography.Token.caption())
                        .foregroundStyle(.white)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 10)
                        .background(
                            Capsule(style: .continuous)
                                .fill(BrandPalette.ink.opacity(0.85))
                        )
                        .opacity(confirmationOpacity)
                        .padding(.bottom, 48)
                }
                .allowsHitTesting(false)
            }
        }
        .environment(gameSession)
        .navigationTitle(selectedGame.rawValue.capitalized)
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showWagerModal) {
            WagerModalView(
                game: selectedGame,
                remainingMinutes: appModel.remainingMinutes
            ) { minutes in
                gameSession.placeWager(game: selectedGame, minutes: minutes)
                showConfirmationBriefly()
            }
            .presentationDetents([.medium])
            .presentationDragIndicator(.visible)
        }
        .onAppear {
            presentWagerIfNeeded()
        }
        .onChange(of: selectedGame) { _, _ in
            presentWagerIfNeeded()
        }
        .onChange(of: gameSession.currentGame) { _, game in
            if game == nil && !showWagerModal {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    showWagerModal = true
                }
            }
        }
    }

    private func presentWagerIfNeeded() {
        if gameSession.currentGame != selectedGame {
            gameSession.clearWager()
            showWagerModal = true
        }
    }

    private func showConfirmationBriefly() {
        showConfirmation = true
        withAnimation(.easeIn(duration: 0.20)) {
            confirmationOpacity = 1
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            withAnimation(.easeOut(duration: 0.35)) {
                confirmationOpacity = 0
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                showConfirmation = false
            }
        }
    }

    @ViewBuilder
    private func gameView(for game: GameType) -> some View {
        switch game {
        case .crash:  CrashView()
        case .plinko: PlinkoView()
        case .mines:  MinesView()
        case .slots:  SlotsView()
        }
    }
}

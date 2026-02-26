import SwiftUI

struct CrashView: View {

    @Environment(AppModel.self) private var appModel
    @Environment(GameSessionModel.self) private var gameSession
    @State private var viewModel: CrashViewModel?

    var body: some View {
        VStack(spacing: 24) {
            Spacer()

            // MARK: Multiplier Display
            if let vm = resolvedViewModel {
                Text(vm.formattedMultiplier)
                    .font(Typography.Token.heroMetric(size: 56))
                    .foregroundColor(multiplierColor(for: vm.phase))
                    .contentTransition(.numericText())
                    .animation(.linear(duration: 0.05), value: vm.displayMultiplier)

                // MARK: Outcome
                if let text = vm.outcomeText {
                    Text(text)
                        .font(Typography.Token.outcome())
                        .foregroundColor(
                            (vm.lastOutcome?.deltaMinutes ?? 0) >= 0
                                ? BrandPalette.highlight
                                : .red
                        )
                        .transition(.scale.combined(with: .opacity))
                }

                // MARK: Wager Info
                if vm.wagerMinutes > 0 {
                    Text("Wagering: \(vm.wagerMinutes) min")
                        .font(Typography.Token.caption())
                        .foregroundStyle(.secondary)
                }

                // MARK: Error
                if let error = vm.errorMessage {
                    Text(error)
                        .font(Typography.Token.caption())
                        .foregroundStyle(.red)
                }
            }

            Spacer()

            // MARK: Action Button
            if let vm = resolvedViewModel {
                actionButton(for: vm)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 16)
            }
        }
        .frame(maxWidth: .infinity)
        .onAppear {
            if viewModel == nil {
                viewModel = CrashViewModel(appModel: appModel)
            }
        }
    }

    // MARK: - Helpers

    private var resolvedViewModel: CrashViewModel? {
        viewModel
    }

    @ViewBuilder
    private func actionButton(for vm: CrashViewModel) -> some View {
        switch vm.phase {
        case .idle:
            Button("Launch") {
                vm.startGame(wagerMinutes: gameSession.currentWagerMinutes)
            }
            .buttonStyle(BrandedActionButtonStyle(
                state: gameSession.hasActiveWager ? .primary : .disabled
            ))
            .disabled(!gameSession.hasActiveWager)

        case .running:
            Button("Cash Out") {
                vm.cashOut()
            }
            .buttonStyle(BrandedActionButtonStyle(state: .primary))

        case .crashed, .cashedOut:
            Button("Play Again") {
                vm.resetForNewRound()
                gameSession.clearWager()
            }
            .buttonStyle(BrandedActionButtonStyle(state: .muted))
        }
    }

    private func multiplierColor(for phase: CrashPhase) -> Color {
        switch phase {
        case .idle:      return .primary
        case .running:   return BrandPalette.ink
        case .cashedOut: return .green
        case .crashed:   return .red
        }
    }
}

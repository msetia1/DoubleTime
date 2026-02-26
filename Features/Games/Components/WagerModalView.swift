import SwiftUI

struct WagerModalView: View {
    let game: GameType
    let remainingMinutes: Int
    let onPlaceWager: (Int) -> Void

    @State private var selectedMinutes: Int?
    @State private var errorMessage: String?
    @Environment(\.dismiss) private var dismiss

    private var effectiveMinutes: Int { selectedMinutes ?? 1 }
    private var remainingAfterWager: Int { max(0, remainingMinutes - effectiveMinutes) }

    var body: some View {
        VStack(spacing: 24) {
            Text(game.rawValue.capitalized)
                .font(Typography.Token.sectionTitle())
                .frame(maxWidth: .infinity, alignment: .center)

            WagerChips(
                maxWagerMinutes: max(0, remainingMinutes),
                currentRemainingMinutes: remainingMinutes,
                selectedMinutes: selectedMinutes,
                showProjection: false
            ) { selected in
                selectedMinutes = selected
                errorMessage = nil
            }

            wagerSummaryLine

            if let error = errorMessage {
                Text(error)
                    .font(Typography.Token.caption())
                    .foregroundStyle(.red)
            }

            Button("Place Wager") {
                let minutes = effectiveMinutes
                if minutes <= 0 {
                    errorMessage = "Choose at least 1 minute"
                } else if minutes > remainingMinutes {
                    errorMessage = "Not enough minutes"
                } else {
                    onPlaceWager(minutes)
                    dismiss()
                }
            }
            .buttonStyle(BrandedActionButtonStyle(state: .primary))
            .padding(.horizontal, 16)
        }
        .padding(.vertical, 24)
        .padding(.horizontal, 16)
        .onAppear {
            if selectedMinutes == nil {
                selectedMinutes = max(1, min(5, remainingMinutes))
            }
        }
    }

    private var wagerSummaryLine: some View {
        HStack(spacing: 6) {
            Text("Wager: \(effectiveMinutes) min")
                .font(Typography.Token.outcome())
                .fontWeight(.bold)
                .foregroundStyle(BrandPalette.accentEnd)
            Text("|")
                .font(Typography.Token.secondary())
                .foregroundStyle(.secondary)
            Text("\(remainingAfterWager) minutes left")
                .font(Typography.Token.secondary())
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .center)
    }
}

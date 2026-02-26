import SwiftUI

struct WagerModalView: View {
    let game: GameType
    let remainingMinutes: Int
    let onPlaceWager: (Int) -> Void

    @State private var selectedMinutes: Int?
    @State private var errorMessage: String?
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 24) {
            Text(game.rawValue.capitalized)
                .font(Typography.Token.sectionTitle())
                .frame(maxWidth: .infinity, alignment: .center)

            WagerChips(
                maxWagerMinutes: max(0, remainingMinutes),
                currentRemainingMinutes: remainingMinutes,
                selectedMinutes: selectedMinutes
            ) { selected in
                selectedMinutes = selected
                errorMessage = nil
            }

            if let error = errorMessage {
                Text(error)
                    .font(Typography.Token.caption())
                    .foregroundStyle(.red)
            }

            Button("Place Wager") {
                let minutes = selectedMinutes ?? 1
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
}

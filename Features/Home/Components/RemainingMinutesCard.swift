import SwiftUI

/// Hero card that shows the single primary value: `remainingMinutes`.
///
/// Breakdowns (allowance, bonus, usage) are visually secondary.
/// When `remainingMinutes == 0`, the hero value appears greyed out per styling.md.
struct RemainingMinutesCard: View {

    let remainingMinutes: Int
    let dailyAllowanceMinutes: Int
    let bonusMinutesFromGames: Int
    let usageMinutesToday: Int

    // MARK: - Brand Colors

    private let brandInk   = Color(red: 0x2E / 255, green: 0x29 / 255, blue: 0x4E / 255)  // #2E294E
    private let brandAccent = Color(red: 0xD9 / 255, green: 0x03 / 255, blue: 0x68 / 255)  // #D90368

    var body: some View {
        VStack(spacing: 12) {

            // MARK: Hero Metric
            Text("\(remainingMinutes)")
                .font(Typography.Token.heroMetric())
                .foregroundStyle(remainingMinutes > 0 ? brandInk : Color.secondary)
                .opacity(remainingMinutes > 0 ? 1.0 : 0.45)
                .contentTransition(.numericText(value: Double(remainingMinutes)))
                .animation(.easeInOut(duration: 0.25), value: remainingMinutes)
                .accessibilityLabel("Remaining minutes: \(remainingMinutes)")

            Text("minutes remaining")
                .font(Typography.Token.secondary())
                .foregroundStyle(.secondary)

            Divider()
                .padding(.horizontal, 16)

            // MARK: Secondary Breakdown
            HStack(spacing: 24) {
                breakdownItem(label: "Allowance", value: "\(dailyAllowanceMinutes)")
                breakdownItem(label: "Bonus", value: bonusString)
                breakdownItem(label: "Used", value: "\(usageMinutesToday)")
            }
            .padding(.bottom, 4)
        }
        .padding(16)
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .accessibilityElement(children: .contain)
    }

    // MARK: - Helpers

    private var bonusString: String {
        if bonusMinutesFromGames >= 0 {
            return "+\(bonusMinutesFromGames)"
        }
        return "\(bonusMinutesFromGames)"
    }

    private func breakdownItem(label: String, value: String) -> some View {
        VStack(spacing: 4) {
            Text(value)
                .font(Typography.Token.controlLabel())
                .foregroundStyle(.primary)
            Text(label)
                .font(Typography.Token.caption())
                .foregroundStyle(.secondary)
        }
        .accessibilityElement(children: .combine)
    }
}

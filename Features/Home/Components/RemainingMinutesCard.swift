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

    var body: some View {
        CardContainer {
            HStack(alignment: .top, spacing: 16) {

                // MARK: Hero Metric
                RemainingMinutesHero(remainingMinutes: remainingMinutes)
                    .frame(maxWidth: .infinity, alignment: .leading)

                // MARK: Secondary Breakdown
                VStack(alignment: .trailing, spacing: 10) {
                    breakdownRow(label: "Allowance", value: "\(dailyAllowanceMinutes)")
                    breakdownRow(label: "Bonus", value: bonusString)
                    breakdownRow(label: "Used", value: "\(usageMinutesToday)")
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .padding(.vertical, 2)
        }
        .frame(maxWidth: .infinity)
        .accessibilityElement(children: .contain)
    }

    // MARK: - Helpers

    private var bonusString: String {
        if bonusMinutesFromGames >= 0 {
            return "+\(bonusMinutesFromGames)"
        }
        return "\(bonusMinutesFromGames)"
    }

    private func breakdownRow(label: String, value: String) -> some View {
        HStack(spacing: 8) {
            Text(label)
                .font(Typography.Token.caption())
                .foregroundStyle(.secondary)
            Text(value)
                .font(Typography.Token.controlLabel())
                .foregroundStyle(.primary)
        }
        .accessibilityElement(children: .combine)
    }
}

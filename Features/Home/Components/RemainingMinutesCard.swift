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
        CardContainer(useWarmTint: true) {
            VStack(spacing: 12) {

                // MARK: Hero Metric
                RemainingMinutesHero(remainingMinutes: remainingMinutes)

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
        }
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

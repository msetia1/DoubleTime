import SwiftUI

struct RemainingMinutesHero: View {
    let remainingMinutes: Int

    var body: some View {
        VStack(spacing: 8) {
            Text("\(remainingMinutes)")
                .font(Typography.Token.heroMetric())
                .foregroundStyle(remainingMinutes > 0 ? BrandPalette.ink : Color.secondary)
                .opacity(remainingMinutes > 0 ? 1 : 0.45)
                .contentTransition(.numericText(value: Double(remainingMinutes)))
                .animation(.easeInOut(duration: 0.25), value: remainingMinutes)
                .accessibilityLabel("Remaining minutes: \(remainingMinutes)")

            Text("minutes remaining")
                .font(Typography.Token.secondary())
                .foregroundStyle(.secondary)
        }
    }
}

import SwiftUI

struct WagerChips: View {
    /// Highest selectable wager. Component renders 1...maxWagerMinutes in a vertical wheel.
    let maxWagerMinutes: Int
    let currentRemainingMinutes: Int
    let selectedMinutes: Int?
    var placeholderMultiplier: Double = 1.8
    var showProjection: Bool = true
    var onSelect: (Int) -> Void

    var body: some View {
        VStack(spacing: 8) {
            if wagerOptions.isEmpty {
                Text("No wagerable minutes available")
                    .font(Typography.Token.secondary())
                    .foregroundStyle(.secondary)
            } else {
                if showProjection {
                    HStack {
                        Spacer()
                        multiplierBadge
                    }
                }

                Picker("Wager minutes", selection: selectionBinding) {
                    ForEach(wagerOptions, id: \.self) { option in
                        HStack(spacing: 4) {
                            Text("\(option)")
                                .font(Typography.Token.heroMetric(size: 42))
                                .fontWeight(option == clampedSelectedMinutes ? .bold : .semibold)
                                .foregroundStyle(Color.secondary)
                            Text("min")
                                .font(Typography.Token.caption())
                                .foregroundStyle(.secondary)
                        }
                        .padding(.vertical, 6)
                        .tag(option)
                    }
                }
                .pickerStyle(.wheel)
                .frame(maxWidth: .infinity)
                .frame(height: 180)
                .clipped()

                if showProjection {
                    projectionPanel
                }
            }
        }
    }

    private var multiplierBadge: some View {
        Text("x\(placeholderMultiplier, specifier: "%.1f")")
            .font(Typography.Token.caption())
            .foregroundStyle(.white)
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            .background(
                Capsule(style: .continuous)
                    .fill(
                        LinearGradient(
                            colors: [BrandPalette.accentStart, BrandPalette.accentEnd],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
            )
            .accessibilityLabel("Multiplier \(placeholderMultiplier, specifier: "%.1f")")
    }

    private var projectionPanel: some View {
        HStack(spacing: 6) {
            Text("\(netDeltaMinutes >= 0 ? "+" : "−")\(abs(netDeltaMinutes)) min")
                .font(Typography.Token.outcome())
                .fontWeight(.bold)
                .foregroundStyle(BrandPalette.accentEnd)
            Text("|")
                .font(Typography.Token.secondary())
                .foregroundStyle(.secondary)
            Text("\(remainingAfterLoss) minutes left")
                .font(Typography.Token.secondary())
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .center)
    }

    private var selectionBinding: Binding<Int> {
        Binding(
            get: { clampedSelectedMinutes },
            set: { onSelect($0) }
        )
    }

    private var wagerOptions: [Int] {
        guard maxWagerMinutes > 0 else { return [] }
        return Array(1...maxWagerMinutes)
    }

    private var clampedSelectedMinutes: Int {
        guard let first = wagerOptions.first else { return 0 }
        let selected = selectedMinutes ?? first
        return min(max(selected, first), wagerOptions.last ?? first)
    }

    private var potentialWinMinutes: Int {
        guard clampedSelectedMinutes > 0 else { return 0 }
        return max(0, Int(floor(Double(clampedSelectedMinutes) * (placeholderMultiplier - 1.0))))
    }

    private var netDeltaMinutes: Int {
        potentialWinMinutes
    }

    private var remainingAfterLoss: Int {
        max(0, currentRemainingMinutes - clampedSelectedMinutes)
    }
}

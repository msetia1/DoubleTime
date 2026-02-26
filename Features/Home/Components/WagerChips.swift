import SwiftUI

struct WagerChip: View {
    let minutes: Int
    var isSelected: Bool
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text("\(minutes) min")
                .font(Typography.Token.caption())
                .frame(minWidth: 44, minHeight: 44)
                .padding(.horizontal, 10)
        }
        .buttonStyle(.plain)
        .foregroundStyle(isSelected ? Color.white : Color.primary)
        .background(chipBackground)
        .overlay(
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .stroke(BrandPalette.ink.opacity(0.20), lineWidth: isSelected ? 0 : 1)
        )
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
        .accessibilityLabel("Wager \(minutes) minutes")
        .accessibilityAddTraits(isSelected ? .isSelected : [])
    }

    private var chipBackground: AnyShapeStyle {
        if isSelected {
            return AnyShapeStyle(LinearGradient(
                colors: [BrandPalette.accentStart, BrandPalette.accentEnd],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            ))
        }
        return AnyShapeStyle(Color(.secondarySystemBackground))
    }
}

struct WagerChips: View {
    let options: [Int]
    let selectedMinutes: Int?
    var onSelect: (Int) -> Void

    var body: some View {
        HStack(spacing: 8) {
            ForEach(options, id: \.self) { option in
                WagerChip(
                    minutes: option,
                    isSelected: selectedMinutes == option
                ) {
                    onSelect(option)
                }
            }
        }
    }
}

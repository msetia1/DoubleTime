import SwiftUI

enum BrandedActionStyleState {
    case primary
    case muted
    case disabled
}

struct BrandedActionButtonStyle: ButtonStyle {
    let state: BrandedActionStyleState

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(Typography.Token.controlLabel())
            .foregroundStyle(textColor)
            .frame(maxWidth: .infinity, minHeight: 52)
            .padding(.horizontal, 16)
            .background(background)
            .overlay(borderOverlay)
            .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
            .saturation(state == .disabled ? 0 : 1)
            .opacity(configuration.isPressed ? 0.92 : baseOpacity)
            .animation(.easeInOut(duration: 0.16), value: configuration.isPressed)
    }

    private var background: AnyShapeStyle {
        switch state {
        case .primary:
            return AnyShapeStyle(LinearGradient(
                colors: [BrandPalette.accentStart, BrandPalette.accentEnd],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            ))
        case .muted, .disabled:
            return AnyShapeStyle(Color(.secondarySystemBackground))
        }
    }

    @ViewBuilder
    private var borderOverlay: some View {
        if state == .muted || state == .disabled {
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .stroke(BrandPalette.ink.opacity(0.20), lineWidth: 1)
        } else {
            EmptyView()
        }
    }

    private var textColor: Color {
        switch state {
        case .primary:
            .white
        case .muted:
            .primary
        case .disabled:
            .secondary
        }
    }

    private var baseOpacity: CGFloat {
        state == .disabled ? 0.55 : 1
    }
}

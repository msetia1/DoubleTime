import SwiftUI

/// Full-width toggle button for locking/unlocking restricted apps.
///
/// Three visual states:
/// - **Unlocked:** branded gradient, "Restricted Apps Unlocked"
/// - **Locked, unlock allowed:** muted fill with subtle border
/// - **Locked, blocked (0 min):** same as locked but greyed out; still tappable for feedback
struct LockToggleButton: View {

    let isLocked: Bool
    let unlockAllowed: Bool
    let onToggle: () async -> Void
    let shakeToggle: Bool

    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var shakeOffset: CGFloat = 0
    @State private var opacityPulse: Double = 1.0

    // MARK: - Brand Colors

    private let gradientStart = Color(red: 0x82 / 255, green: 0x02 / 255, blue: 0x63 / 255) // #820263
    private let gradientEnd   = Color(red: 0xD9 / 255, green: 0x03 / 255, blue: 0x68 / 255) // #D90368

    var body: some View {
        Button {
            Task { await onToggle() }
        } label: {
            Text(isLocked ? "Restricted Apps Locked" : "Restricted Apps Unlocked")
                .font(Typography.Token.controlLabel())
                .foregroundColor(isLocked ? Color.primary : Color.white)
                .frame(maxWidth: .infinity)
                .frame(minHeight: 44)
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(background)
                .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                .overlay(lockedBorder)
        }
        .buttonStyle(.plain)
        .opacity(isLocked && !unlockAllowed ? 0.45 : 1.0)
        .offset(x: shakeOffset)
        .opacity(opacityPulse)
        .animation(.easeInOut(duration: 0.25), value: isLocked)
        .animation(.easeInOut(duration: 0.25), value: unlockAllowed)
        .onChange(of: shakeToggle) {
            fireShake()
        }
        .accessibilityLabel(isLocked ? "Restricted apps locked" : "Restricted apps unlocked")
    }

    // MARK: - Background

    @ViewBuilder
    private var background: some View {
        if isLocked {
            Color(.secondarySystemBackground)
        } else {
            LinearGradient(
                colors: [gradientStart, gradientEnd],
                startPoint: .leading,
                endPoint: .trailing
            )
        }
    }

    @ViewBuilder
    private var lockedBorder: some View {
        if isLocked {
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .strokeBorder(Color.secondary.opacity(0.3), lineWidth: 1)
        }
    }

    // MARK: - Shake Animation

    private func fireShake() {
        if reduceMotion {
            // Opacity pulse for Reduce Motion users
            withAnimation(.easeInOut(duration: 0.15)) {
                opacityPulse = 0.5
            }
            withAnimation(.easeInOut(duration: 0.15).delay(0.15)) {
                opacityPulse = 1.0
            }
        } else {
            // Horizontal shake
            withAnimation(.default) {
                shakeOffset = -8
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.04) {
                withAnimation(.default) { shakeOffset = 8 }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.08) {
                withAnimation(.default) { shakeOffset = -4 }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.12) {
                withAnimation(.spring(duration: 0.06)) { shakeOffset = 0 }
            }
        }
    }
}

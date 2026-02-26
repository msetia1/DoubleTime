import SwiftUI

/// Small inline message that fades in, shows briefly, then auto-dismisses.
///
/// Used below the lock toggle to show "0 minutes remaining" when the user
/// taps unlock with no time left.
struct InlineStatusMessage: View {

    @Binding var isVisible: Bool

    let text: String

    @State private var opacity: Double = 0

    var body: some View {
        Group {
            if isVisible {
                Text(text)
                    .font(Typography.Token.caption())
                    .foregroundStyle(.secondary)
                    .opacity(opacity)
                    .onAppear {
                        withAnimation(.easeIn(duration: 0.20)) {
                            opacity = 1.0
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                            withAnimation(.easeOut(duration: 0.35)) {
                                opacity = 0
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                                isVisible = false
                            }
                        }
                    }
                    .onDisappear {
                        opacity = 0
                    }
            }
        }
    }
}

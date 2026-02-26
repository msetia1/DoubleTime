import SwiftUI

struct InlineStatusMessage: View {
    let text: String
    var isVisible: Bool
    var isError: Bool = false

    var body: some View {
        Text(text)
            .font(Typography.Token.secondary())
            .foregroundStyle(isError ? Color.red : Color.secondary)
            .multilineTextAlignment(.center)
            .frame(maxWidth: .infinity)
            .opacity(isVisible ? 1 : 0)
            .animation(.easeInOut(duration: 0.20), value: isVisible)
            .accessibilityHidden(!isVisible)
    }
}

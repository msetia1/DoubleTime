import SwiftUI

struct CardContainer<Content: View>: View {
    private let useWarmTint: Bool
    @ViewBuilder private let content: () -> Content

    init(useWarmTint: Bool = false, @ViewBuilder content: @escaping () -> Content) {
        self.useWarmTint = useWarmTint
        self.content = content
    }

    var body: some View {
        content()
            .padding(16)
            .background(backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
    }

    private var backgroundColor: Color {
        if useWarmTint {
            return BrandPalette.warmSurface.opacity(0.25)
        }
        return Color(.secondarySystemBackground)
    }
}

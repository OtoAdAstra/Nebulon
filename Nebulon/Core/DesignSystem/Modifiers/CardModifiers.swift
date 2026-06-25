import SwiftUI

struct MaterialCardModifier: ViewModifier {
    var cornerRadius: CGFloat = Design.cardRadius

    func body(content: Content) -> some View {
        if #available(iOS 26, *) {
            content
                .glassEffect(.regular, in: RoundedRectangle(cornerRadius: cornerRadius))
                .overlay(stroke)
        } else {
            content
                .background(.ultraThinMaterial.opacity(0.6))
                .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
                .overlay(stroke)
        }
    }

    private var stroke: some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .stroke(.white.opacity(Design.borderOpacity), lineWidth: Design.borderWidth)
    }
}

struct CardBackgroundModifier: ViewModifier {
    var cornerRadius: CGFloat = Design.cardRadius

    func body(content: Content) -> some View {
        content
            .background(Color.white.opacity(Design.cardBackgroundOpacity))
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
    }
}

extension View {
    /// Frosted glass card style with material background and border
    func materialCard(cornerRadius: CGFloat = Design.cardRadius) -> some View {
        modifier(MaterialCardModifier(cornerRadius: cornerRadius))
    }

    /// Subtle translucent card background
    func cardBackground(cornerRadius: CGFloat = Design.cardRadius) -> some View {
        modifier(CardBackgroundModifier(cornerRadius: cornerRadius))
    }
}

import SwiftUI

struct MaterialCardModifier: ViewModifier {
    var cornerRadius: CGFloat = Design.cardRadius
    var cardOpacity: CGFloat = Design.cardBackgroundOpacity

    func body(content: Content) -> some View {
        if #available(iOS 26, *) {
            content
                .glassEffect(
                    .clear,
                    in: RoundedRectangle(cornerRadius: cornerRadius)
                )
        } else {
            content
                .background(.ultraThinMaterial.opacity(cardOpacity))
                .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
                .overlay(stroke)
        }
    }

    private var stroke: some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .stroke(.white.opacity(Design.borderOpacity), lineWidth: Design.borderWidth)
    }
}

extension View {

    func materialCard(cornerRadius: CGFloat = Design.cardRadius) -> some View {
        modifier(MaterialCardModifier(cornerRadius: cornerRadius))
    }
    
}

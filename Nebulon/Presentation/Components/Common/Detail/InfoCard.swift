import SwiftUI

/// Material card with a headline title — the shared shell for
/// Description / Details / Keywords sections on detail screens.
struct InfoCard<Content: View>: View {
    let title: String
    var spacing: CGFloat = 10
    @ViewBuilder let content: () -> Content

    var body: some View {
        VStack(alignment: .leading, spacing: spacing) {
            Text(title)
                .font(.headline)
                .foregroundStyle(.white)

            content()
        }
        .padding(Design.cardRadius)
        .frame(maxWidth: .infinity, alignment: .leading)
        .materialCard()
        .padding(.horizontal, Design.contentPadding)
    }
}

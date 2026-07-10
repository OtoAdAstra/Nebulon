import SwiftUI

struct DetailHero<Media: View>: View {
    let title: String
    var onTap: (() -> Void)? = nil
    @ViewBuilder let media: () -> Media

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Color.clear
                .containerRelativeFrame(.vertical) { length, _ in
                    length * Design.heroImageRatio
                }
                .frame(maxWidth: .infinity)
                .overlay { media() }
                .clipped()
                .mask(
                    VStack(spacing: 0) {
                        Color.white
                        LinearGradient(
                            colors: [.white, .clear],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        .frame(height: Design.heroFadeHeight)
                    }
                )
                .onTapGesture { onTap?() }

            Text(title)
                .font(.title.bold())
                .foregroundStyle(.white)
                .padding(.horizontal, Design.contentPadding)
                .padding(.bottom, Design.contentPadding)
        }
        .clipShape(
            .rect(
                topLeadingRadius: Design.sectionPadding,
                topTrailingRadius: Design.sectionPadding
            )
        )
    }
}

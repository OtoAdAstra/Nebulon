import SwiftUI

struct MediaCardView: View {
    let media: SpaceMedia
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            Color.clear
                .aspectRatio(1, contentMode: .fit)
                .overlay {
                    CachedAsyncImage(url: media.thumbnailURL) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    } placeholder: {
                        Rectangle()
                            .fill(.white.opacity(Design.imagePlaceholderOpacity))
                            .overlay {
                                Image(systemName: "photo")
                                    .font(.system(size: 24))
                                    .foregroundStyle(.white.opacity(0.15))
                            }
                    }
                }
                .overlay(alignment: .bottom) { titleScrim }
                .clipShape(RoundedRectangle(cornerRadius: Design.cardRadius, style: .continuous))
                .overlay {
                    RoundedRectangle(cornerRadius: Design.cardRadius, style: .continuous)
                        .stroke(.white.opacity(Design.borderOpacity), lineWidth: Design.borderWidth)
                }
        }
        .buttonStyle(.plain)
    }

    private var titleScrim: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(media.title)
                .font(Design.cardTitleFont)
                .foregroundStyle(.white)
                .lineLimit(2)
                .multilineTextAlignment(.leading)

            if let year = media.dateCreated.map({ $0.formatted(.dateTime.year()) }) {
                Text(year)
                    .font(Design.cardCaptionFont)
                    .foregroundStyle(.white.opacity(Design.tertiaryTextOpacity))
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(10)
        .background {
            LinearGradient(
                colors: [.clear, .black.opacity(0.75)],
                startPoint: .top,
                endPoint: .bottom
            )
        }
    }
}

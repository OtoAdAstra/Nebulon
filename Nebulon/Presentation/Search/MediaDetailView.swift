import SwiftUI

struct MediaDetailView: View {
    let media: SpaceMedia
    var onDismiss: () -> Void

    var body: some View {
        NavigationContainer(onDismiss: onDismiss) {
            DetailScreen(
                title: media.title,
                description: media.description,
                details: detailItems,
                fullScreenImageURL: (media.imageURL ?? media.thumbnailURL)?.absoluteString
            ) {
                heroImage
            } footer: {
                if !media.keywords.isEmpty {
                    keywordsCard
                }
            }
        }
    }

    // MARK: - Media

    private var heroImage: some View {
        CachedAsyncImage(url: media.imageURL ?? media.thumbnailURL) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
        } placeholder: {
            CachedAsyncImage(url: media.thumbnailURL) { thumb in
                thumb
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                Rectangle().fill(.white.opacity(Design.imagePlaceholderOpacity))
            }
        }
    }

    // MARK: - Details

    private var detailItems: [DetailItem] {
        var items: [DetailItem] = []

        if let date = media.dateCreated {
            items.append(DetailItem(
                icon: "calendar",
                iconColor: .blue,
                label: "Date",
                value: date.formatted(date: .long, time: .omitted)
            ))
        }

        if let center = media.center {
            items.append(DetailItem(
                icon: "building.2",
                iconColor: .purple,
                label: "NASA Center",
                value: center
            ))
        }

        if let photographer = media.photographer {
            items.append(DetailItem(
                icon: "c.circle",
                iconColor: .brown,
                label: "Credit",
                value: photographer
            ))
        }

        items.append(DetailItem(
            icon: "number",
            iconColor: .orange,
            label: "NASA ID",
            value: media.id
        ))

        return items
    }

    // MARK: - Keywords

    private var keywordsCard: some View {
        InfoCard(title: "Keywords", spacing: 14) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(media.keywords, id: \.self) { keyword in
                        TagChip(title: keyword)
                    }
                }
            }
        }
    }
}

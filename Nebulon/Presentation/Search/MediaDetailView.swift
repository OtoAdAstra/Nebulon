import SwiftUI

// Mirrors APODView's layout: hero with fade + overlaid title,
// action buttons row, then material cards

struct MediaDetailView: View {
    let media: SpaceMedia
    var onDismiss: () -> Void

    @State private var isImageFullScreen = false
    @State private var isExpanded = false

    var body: some View {
        NavigationContainer(onDismiss: onDismiss) {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 0) {
                    hero
                    actionButtons

                    if let description = media.description, !description.isEmpty {
                        descriptionCard(description)
                    }

                    detailsCard

                    if !media.keywords.isEmpty {
                        keywordsCard
                    }

                    Spacer(minLength: 40)
                }
            }
            .ignoresSafeArea(edges: .top)
        }
        .fullScreenCover(isPresented: $isImageFullScreen) {
            FullScreenAPODImageView(url: fullImageURLString)
        }
    }

    private var fullImageURLString: String {
        (media.imageURL ?? media.thumbnailURL)?.absoluteString ?? ""
    }

    // MARK: - Hero

    private var hero: some View {
        ZStack(alignment: .bottomLeading) {
            // Color.clear owns the layout size; the image lives in an overlay so
            // its .fill overflow can never widen the VStack past the screen
            Color.clear
                .containerRelativeFrame(.vertical) { length, _ in
                    length * Design.heroImageRatio
                }
                .frame(maxWidth: .infinity)
                .overlay {
                    // Grid's thumbnail is already cached — instant placeholder
                    // while the full-size image loads
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
                .onTapGesture {
                    withAnimation(
                        .spring(response: 0.35, dampingFraction: 0.85)
                    ) {
                        isImageFullScreen = true
                    }
                }

            Text(media.title)
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

    // MARK: - Action Buttons

    private var actionButtons: some View {
        HStack(spacing: Design.itemSpacing) {
            ActionButton(icon: "document.on.document", label: "Copy") {}
            ActionButton(icon: "square.and.arrow.up", label: "Share") {}
            ActionButton(icon: "arrow.down.to.line", label: "Wallpaper") {}
        }
        .padding(.horizontal, Design.contentPadding)
        .padding(.vertical, Design.cardRadius)
    }

    // MARK: - Description

    private func descriptionCard(_ description: String) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Description")
                .font(.headline)
                .foregroundStyle(.white)

            Text(description)
                .font(.subheadline)
                .foregroundStyle(.white.opacity(0.75))
                .lineSpacing(5)
                .lineLimit(isExpanded ? nil : 4)

            Button(isExpanded ? "Show less" : "Read more") {
                withAnimation(.easeInOut(duration: 0.2)) {
                    isExpanded.toggle()
                }
            }
            .font(.subheadline.weight(.medium))
            .foregroundStyle(Color(red: 0.3, green: 0.6, blue: 1.0))
        }
        .padding(Design.cardRadius)
        .frame(maxWidth: .infinity, alignment: .leading)
        .materialCard()
        .padding(.horizontal, Design.contentPadding)
    }

    // MARK: - Details

    private var detailsCard: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Details")
                .font(.headline)
                .foregroundStyle(.white)
                .padding(.bottom, 14)

            if let date = media.dateCreated {
                DetailRow(
                    icon: "calendar",
                    iconColor: .blue,
                    label: "Date",
                    value: date.formatted(date: .long, time: .omitted)
                )
            }

            if let center = media.center {
                DetailRow(
                    icon: "building.2",
                    iconColor: .purple,
                    label: "NASA Center",
                    value: center
                )
            }

            if let photographer = media.photographer {
                DetailRow(
                    icon: "c.circle",
                    iconColor: .brown,
                    label: "Credit",
                    value: photographer
                )
            }

            DetailRow(
                icon: "number",
                iconColor: .orange,
                label: "NASA ID",
                value: media.id
            )
        }
        .padding(Design.cardRadius)
        .frame(maxWidth: .infinity, alignment: .leading)
        .materialCard()
        .padding(.horizontal, Design.contentPadding)
        .padding(.vertical, Design.cardRadius)
    }

    // MARK: - Keywords

    private var keywordsCard: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("Keywords")
                .font(.headline)
                .foregroundStyle(.white)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(media.keywords, id: \.self) { keyword in
                        TagChip(title: keyword)
                    }
                }
            }
        }
        .padding(Design.cardRadius)
        .frame(maxWidth: .infinity, alignment: .leading)
        .materialCard()
        .padding(.horizontal, Design.contentPadding)
    }
}

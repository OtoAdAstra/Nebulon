import SwiftUI

struct DetailItem: Identifiable {
    let icon: String
    let iconColor: Color
    let label: String
    let value: String

    var id: String { label }
}

struct HeroGeometry {
    let id: String
    let namespace: Namespace.ID
}

struct DetailScreen<Media: View, Footer: View>: View {
    let title: String
    let description: String?
    let details: [DetailItem]

    var fullScreenImageURL: String? = nil
    var heroGeometry: HeroGeometry? = nil

    @ViewBuilder let media: () -> Media
    @ViewBuilder let footer: () -> Footer

    @State private var isImageFullScreen = false
    @Namespace private var zoomNamespace

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 0) {
                hero
                DetailActionBar()

                if let description, !description.isEmpty {
                    DescriptionCard(text: description)
                }

                if !details.isEmpty {
                    detailsCard
                }

                footer()

                Spacer(minLength: 40)
            }
        }
        .ignoresSafeArea(edges: .top)
        .fullScreenCover(isPresented: $isImageFullScreen) {
            FullScreenImageView(url: fullScreenImageURL ?? "")
                .zoomTransition(sourceID: "detail_zoom", in: zoomNamespace)
        }
    }

    // MARK: - Hero

    @ViewBuilder
    private var hero: some View {
        let base = DetailHero(
            title: title,
            onTap: fullScreenImageURL == nil ? nil : { isImageFullScreen = true },
            media: media
        )
        .zoomTransitionSource(id: "detail_zoom", in: zoomNamespace)

        if let heroGeometry {
            base.matchedGeometryEffect(id: heroGeometry.id, in: heroGeometry.namespace)
        } else {
            base
        }
    }

    // MARK: - Details

    private var detailsCard: some View {
        InfoCard(title: "Details", spacing: 14) {
            VStack(alignment: .leading, spacing: 0) {
                ForEach(details) { item in
                    DetailRow(
                        icon: item.icon,
                        iconColor: item.iconColor,
                        label: item.label,
                        value: item.value
                    )
                }
            }
        }
        .padding(.vertical, Design.cardRadius)
    }
}

// MARK: - Footer-less convenience

extension DetailScreen where Footer == EmptyView {
    init(
        title: String,
        description: String?,
        details: [DetailItem],
        fullScreenImageURL: String? = nil,
        heroGeometry: HeroGeometry? = nil,
        @ViewBuilder media: @escaping () -> Media
    ) {
        self.init(
            title: title,
            description: description,
            details: details,
            fullScreenImageURL: fullScreenImageURL,
            heroGeometry: heroGeometry,
            media: media,
            footer: { EmptyView() }
        )
    }
}

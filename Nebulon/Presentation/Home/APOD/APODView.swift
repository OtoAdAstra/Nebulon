import SwiftUI

struct APODView: View {
    let viewModel: APODViewModel
    var heroNamespace: Namespace.ID
    var onDismiss: () -> Void

    private var apod: APOD? { viewModel.apod }

    var body: some View {
        DetailScreen(
            title: apod?.title ?? "",
            description: apod?.explanation,
            details: detailItems,
            fullScreenImageURL: apod?.isVideo == true ? nil : apod?.url,
            heroGeometry: HeroGeometry(id: "apod_hero", namespace: heroNamespace)
        ) {
            MediaView(
                url: apod?.url ?? "",
                isVideo: apod?.isVideo ?? false
            )
        }
        .overlay(alignment: .topTrailing) {
            DismissButton { onDismiss() }
                .padding(.leading, Design.cardRadius)
                .padding(.top, 8)
        }
    }

    private var detailItems: [DetailItem] {
        var items = [
            DetailItem(
                icon: "calendar",
                iconColor: .blue,
                label: "Date",
                value: apod?.date ?? ""
            ),
            DetailItem(
                icon: "camera",
                iconColor: .purple,
                label: "Media Type",
                value: apod?.mediaType.capitalized ?? ""
            ),
        ]

        if let copyright = apod?.copyright {
            items.append(DetailItem(
                icon: "c.circle",
                iconColor: .brown,
                label: "Copyright",
                value: copyright
            ))
        }

        return items
    }
}

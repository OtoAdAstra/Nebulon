import SwiftUI

struct NewsView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            SectionHeader(title: "News")

            VStack(spacing: 0) {
                NewsRow(
                    icon: "newspaper.fill",
                    title: "Webb Spots Exoplanet Clouds",
                    subtitle: "New findings from JWST",
                    url: "https://www.nasa.gov/news/"
                )

                Divider()
                    .overlay(.white.opacity(0.06))
                    .padding(.leading, 56)

                NewsRow(
                    icon: "flame.fill",
                    title: "Artemis III Update",
                    subtitle: "Mission progress report",
                    url: "https://www.nasa.gov/news/"
                )
            }
            .materialCard()
        }
    }
}

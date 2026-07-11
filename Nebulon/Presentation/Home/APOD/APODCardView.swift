import SwiftUI

struct APODCardView: View {
    let viewModel: APODViewModel

    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .bottomLeading) {
                MediaView(url: viewModel.apod?.url ?? "", isVideo: viewModel.apod?.isVideo ?? false)
                    .frame(width: geo.size.width, height: geo.size.height)
                    .clipped()

                LinearGradient(
                    colors: [.clear, .clear, .black.opacity(0.7)],
                    startPoint: .top,
                    endPoint: .bottom
                )

                VStack(alignment: .leading, spacing: 8) {
                    Text("Astronomy Picture of the Day")
                        .font(Design.badgeFont)
                        .foregroundStyle(.white)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(Color("LightSpace"), in: Capsule())

                    Text(viewModel.apod?.title ?? "")
                        .font(.title2.bold())
                        .foregroundStyle(.white)
                        .lineLimit(2)

                    Text(viewModel.apod?.explanation ?? "")
                        .font(.subheadline)
                        .foregroundStyle(.white.opacity(0.75))
                        .lineLimit(2)

                    Text(viewModel.apod?.date ?? "")
                        .font(.caption)
                        .foregroundStyle(.white.opacity(Design.tertiaryTextOpacity))
                }
                .padding(.vertical, Design.sectionPadding)
                .padding(.horizontal, Design.cardRadius)
            }
            .shadow(color: .black.opacity(0.4), radius: 0.5, x: 0, y: 0)
        }
    }
}

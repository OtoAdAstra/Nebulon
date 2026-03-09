import SwiftUI

struct APODCardView: View {
    let viewModel: APODViewModel

    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .bottomLeading) {

                // Media — fill the card, clipped to bounds
                MediaView(url: viewModel.apod?.url ?? "", isVideo: viewModel.apod?.isVideo ?? false)
                    .frame(width: geo.size.width, height: geo.size.height)
                    .clipped()

                // Gradient
                LinearGradient(
                    colors: [.clear, .clear, .black.opacity(0.9)],
                    startPoint: .top,
                    endPoint: .bottom
                )

                // Text content
                VStack(alignment: .leading, spacing: 8) {

                    // Pill
                    Text("Astronomy Picture of the Day")
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundStyle(.white)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(Color("LightSpace"), in: Capsule())

                    // Title
                    Text(viewModel.apod?.title ?? "")
                        .font(.title2.bold())
                        .foregroundStyle(.white)
                        .lineLimit(2)

                    // Explanation
                    Text(viewModel.apod?.explanation ?? "")
                        .font(.subheadline)
                        .foregroundStyle(.white.opacity(0.75))
                        .lineLimit(2)

                    // Date
                    Text(viewModel.apod?.date ?? "")
                        .font(.caption)
                        .foregroundStyle(.white.opacity(0.5))
                }
                .padding(.vertical, 28)
                .padding(.horizontal, 16)
            }
        }
        .aspectRatio(0.85, contentMode: .fit)
        .clipShape(RoundedRectangle(cornerRadius: 34))
        .shadow(color: .white.opacity(1), radius: 0.5, x: 0, y: 0)
    }

    // Separate media view — handles both image and video
//    @ViewBuilder
//    private var mediaView: some View {
//        if viewModel.apod?.isVideo == true {
//            // Video — show play icon placeholder
//            ZStack {
//                Rectangle()
//                    .fill(.gray.opacity(0.2))
//
//                VStack(spacing: 12) {
//                    Image(systemName: "play.circle.fill")
//                        .font(.system(size: 64))
//                        .foregroundStyle(.white.opacity(0.7))
//
//                    Text("Video")
//                        .font(.caption)
//                        .foregroundStyle(.white.opacity(0.4))
//                }
//            }
//        } else {
//            CachedAsyncImage(
//                url: URL(string: viewModel.apod?.url ?? "")
//            ) { image in
//                image
//                    .resizable()
//                    .aspectRatio(contentMode: .fill)
//            } placeholder: {
//                Rectangle().fill(.gray.opacity(0.2))
//            }
//        }
//    }
}

#Preview {
    HomeView(
        viewModel: APODViewModel(
            fetchAPODUseCase: FetchAPODUseCase(
                repository: APODRepository(client: NetworkClient())
            )
        )
    )
}

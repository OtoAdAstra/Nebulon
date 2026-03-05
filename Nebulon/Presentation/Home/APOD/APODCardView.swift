import SwiftUI

struct APODCardView: View {
    let viewModel: APODViewModel

    var body: some View {
        ZStack(alignment: .bottomLeading) {

            // Media
            mediaView

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
                    .background(.ultraThinMaterial, in: Capsule())

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
            .padding(16)
        }
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .frame(maxWidth: .infinity)
        .aspectRatio(0.75, contentMode: .fit)
    }

    // Separate media view — handles both image and video
    @ViewBuilder
    private var mediaView: some View {
        if viewModel.apod?.isVideo == true {
            // Video — show play icon placeholder
            ZStack {
                Rectangle()
                    .fill(.gray.opacity(0.2))

                VStack(spacing: 12) {
                    Image(systemName: "play.circle.fill")
                        .font(.system(size: 64))
                        .foregroundStyle(.white.opacity(0.7))

                    Text("Video")
                        .font(.caption)
                        .foregroundStyle(.white.opacity(0.4))
                }
            }
        } else {
            AsyncImage(url: URL(string: viewModel.apod?.url ?? "")) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                case .empty, .failure:
                    Rectangle().fill(.gray.opacity(0.2))
                @unknown default:
                    EmptyView()
                }
            }
        }
    }
}

#Preview {
    HomeView(viewModel: APODViewModel(fetchAPODUseCase: FetchAPODUseCase(repository: APODRepository(client: NetworkClient()))))
}

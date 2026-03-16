import SwiftUI

struct APODView: View {
    let viewModel: APODViewModel
    var heroNamespace: Namespace.ID
    var onDismiss: () -> Void

    @State private var isImageFullScreen = false
    @State private var isExpanded = false

    private let imageHeight: CGFloat = UIScreen.main.bounds.height * 0.6

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {

                // MARK: - Hero Image
                ZStack(alignment: .bottomLeading) {
                    Color.clear
                        .frame(height: imageHeight)
                        .overlay {
                            MediaView(
                                url: viewModel.apod?.url ?? "",
                                isVideo: viewModel.apod?.isVideo ?? false
                            )
                        }
                        .clipped()
                        .matchedGeometryEffect(id: "apod_hero", in: heroNamespace)
                        .overlay(alignment: .bottom) {
                            LinearGradient(
                                colors: [.clear, Color(red: 0x0B/255, green: 0x0F/255, blue: 0x1A/255)],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                            .frame(height: imageHeight * 0.15)
                        }
                        .onTapGesture {
                            guard viewModel.apod?.isVideo != true else { return }
                            withAnimation(.spring(response: 0.35, dampingFraction: 0.85)) {
                                isImageFullScreen = true
                            }
                        }

                    // Back button
                    VStack {
                        HStack {
                            Button {
                                onDismiss()
                            } label: {
                                Image(systemName: "chevron.left")
                                    .font(.system(size: 18, weight: .semibold))
                                    .foregroundStyle(.white)
                                    .frame(width: 36, height: 36)
                                    .background(.ultraThinMaterial, in: Circle())
                            }
                            .padding(.leading, 16)
                            .padding(.top, 54)
                            Spacer()
                        }
                        Spacer()
                    }

                    // Title over image
                    Text(viewModel.apod?.title ?? "")
                        .font(.title.bold())
                        .foregroundStyle(.white)
                        .padding(.horizontal, 20)
                        .padding(.bottom, 20)
                }

                // MARK: - Action Buttons
                HStack(spacing: 12) {
                    ActionButton(icon: "bookmark", label: "Save") {
                        // save action
                    }
                    ActionButton(icon: "square.and.arrow.up", label: "Share") {
                    }
                    ActionButton(icon: "arrow.down.to.line", label: "Wallpaper") {
                        // wallpaper action
                    }
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 16)

                // MARK: - Description Card
                VStack(alignment: .leading, spacing: 10) {
                    Text("Description")
                        .font(.headline)
                        .foregroundStyle(.white)

                    Text(viewModel.apod?.explanation ?? "")
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
                .padding(16)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.white.opacity(0.05))
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .padding(.horizontal, 20)

                // MARK: - Details Card
                VStack(alignment: .leading, spacing: 0) {
                    Text("Details")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .padding(.bottom, 14)

                    DetailRow(
                        icon: "calendar",
                        iconColor: Color.blue,
                        label: "Date",
                        value: viewModel.apod?.date ?? ""
                    )

                    Divider()
                        .overlay(Color.white.opacity(0.08))
                        .padding(.vertical, 8)

                    DetailRow(
                        icon: "camera",
                        iconColor: Color.purple,
                        label: "Media Type",
                        value: viewModel.apod?.mediaType.capitalized ?? ""
                    )

                    Divider()
                        .overlay(Color.white.opacity(0.08))
                        .padding(.vertical, 8)

                    DetailRow(
                        icon: "info.circle",
                        iconColor: Color.green,
                        label: "Service",
                        value: viewModel.apod?.serviceVersion ?? ""
                    )
                }
                .padding(16)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.white.opacity(0.05))
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .padding(.horizontal, 20)
                .padding(.vertical, 16)
            }
        }
        .ignoresSafeArea(edges: .top)
        .task {
            await viewModel.onAppear()
        }
        .fullScreenCover(isPresented: $isImageFullScreen) {
            FullScreenAPODImageView(url: viewModel.apod?.url ?? "")
        }
    }
}

// MARK: - Supporting Views

struct ActionButton: View {
    let icon: String
    let label: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 6) {
                Image(systemName: icon)
                    .font(.system(size: 16, weight: .medium))
                Text(label)
                    .font(.system(size: 12, weight: .medium))
            }
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .background(Color.white.opacity(0.08))
            .clipShape(RoundedRectangle(cornerRadius: 14))
        }
    }
}

struct DetailRow: View {
    let icon: String
    let iconColor: Color
    let label: String
    let value: String

    var body: some View {
        HStack(spacing: 14) {
            ZStack {
                Circle()
                    .fill(iconColor.opacity(0.2))
                    .frame(width: 36, height: 36)
                Image(systemName: icon)
                    .font(.system(size: 14))
                    .foregroundStyle(iconColor)
            }

            VStack(alignment: .leading, spacing: 2) {
                Text(label)
                    .font(.caption)
                    .foregroundStyle(.white.opacity(0.5))
                Text(value)
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(.white)
            }
        }
    }
}

#Preview {
    @Previewable @Namespace var ns
    APODView(
        viewModel: APODViewModel(
            fetchAPODUseCase: FetchAPODUseCase(
                repository: APODRepository(client: NetworkClient())
            )
        ),
        heroNamespace: ns,
        onDismiss: {}
    )
}

import SwiftUI

struct SearchView: View {
    var coordinator: SearchCoordinator

    var body: some View {
        ZStack {
            switch coordinator.route {
                case .list:
                    SearchListView(viewModel: coordinator.searchViewModel) { media in
                        withAnimation(.easeInOut(duration: 0.3)) {
                            coordinator.showDetail(media)
                        }
                    }

                case .detail(let media):
                    MediaDetailView(media: media) {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            coordinator.dismissDetail()
                        }
                    }
                    .transition(.move(edge: .trailing))
            }
        }
    }
}

// MARK: - List

private struct SearchListView: View {
    @Bindable var viewModel: SearchViewModel
    let onSelect: (SpaceMedia) -> Void

    private let columns = [
        GridItem(.flexible(), spacing: Design.itemSpacing),
        GridItem(.flexible(), spacing: Design.itemSpacing),
    ]

    var body: some View {
        ScrollView(showsIndicators: false) {
            content
                .padding(.horizontal, Design.contentPadding)
                .padding(.bottom, Design.tabBarClearance)
        }
        .scrollDismissesKeyboard(.immediately)
        .safeAreaInset(edge: .top) {
            GlassSearchBar(text: $viewModel.query)
                .padding(.horizontal, Design.contentPadding)
                .padding(.vertical, 8)
        }
    }

    @ViewBuilder
    private var content: some View {
        switch viewModel.state {
            case .idle:
                discoverSection

            case .loading:
                skeletonGrid

            case .loaded, .dataLoaded:
                if viewModel.results.isEmpty {
                    emptyState
                } else {
                    resultsGrid
                }

            case .error(let message):
                errorState(message)
        }
    }

    // MARK: Discover (idle)

    private var discoverSection: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("DISCOVER")
                .header()
                .padding(.top, 24)
                .padding(.horizontal, Design.contentPadding)

            LazyVGrid(
                columns: [GridItem(.adaptive(minimum: Design.chipMinWidth), spacing: Design.itemSpacing)],
                spacing: Design.itemSpacing
            ) {
                ForEach(viewModel.suggestions, id: \.self) { suggestion in
                    TagChip(
                        title: suggestion,
                        icon: "sparkle.magnifyingglass",
                        fillsWidth: true
                    ) {
                        viewModel.selectSuggestion(suggestion)
                    }
                }
            }
            .padding(.horizontal, Design.contentPadding)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    // MARK: Results

    private var resultsGrid: some View {
        VStack(alignment: .leading, spacing: Design.itemSpacing) {
            Text("\(viewModel.totalHits.formatted()) results")
                .font(.system(size: 13))
                .foregroundStyle(.white.opacity(Design.tertiaryTextOpacity))
                .padding(.top, 8)

            LazyVGrid(columns: columns, spacing: Design.itemSpacing) {
                ForEach(viewModel.results) { media in
                    MediaCardView(media: media) {
                        onSelect(media)
                    }
                    .onAppear {
                        viewModel.loadMoreIfNeeded(current: media)
                    }
                }
            }

            if viewModel.isLoadingMore {
                ProgressView()
                    .tint(.white.opacity(0.6))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
            }
        }
    }

    private var skeletonGrid: some View {
        LazyVGrid(columns: columns, spacing: Design.itemSpacing) {
            ForEach(0..<6, id: \.self) { _ in
                SkeletonCard()
            }
        }
        .padding(.top, 8)
    }

    // MARK: Empty & Error

    private var emptyState: some View {
        StatusMessageView(
            icon: "sparkle.magnifyingglass",
            title: "No results",
            message: "Nothing found for \u{201C}\(viewModel.query)\u{201D}.\nTry another corner of the universe."
        )
    }

    private func errorState(_ message: String) -> some View {
        StatusMessageView(
            icon: "wifi.exclamationmark",
            title: "Something went wrong",
            message: message
        ) {
            Button("Try Again") {
                viewModel.retry()
            }
            .font(.system(size: 15, weight: .semibold))
            .foregroundStyle(Color("LightCyan"))
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            .background {
                Capsule()
                    .fill(.ultraThinMaterial)
                    .overlay {
                        Capsule().stroke(
                            .white.opacity(Design.glassStrokeOpacity),
                            lineWidth: Design.glassStrokeWidth
                        )
                    }
            }
            .buttonStyle(.plain)
        }
    }
}

// MARK: - Skeleton Card

/// Loading placeholder shaped exactly like a MediaCardView cell
private struct SkeletonCard: View {
    @State private var pulsing = false

    var body: some View {
        RoundedRectangle(cornerRadius: Design.cardRadius, style: .continuous)
            .fill(.white.opacity(pulsing ? 0.10 : 0.04))
            .aspectRatio(1, contentMode: .fit)
            .animation(
                .easeInOut(duration: 0.9).repeatForever(autoreverses: true),
                value: pulsing
            )
            .onAppear { pulsing = true }
    }
}

// MARK: - Status Message

private struct StatusMessageView<Action: View>: View {
    let icon: String
    let title: String
    let message: String
    @ViewBuilder var action: () -> Action

    init(
        icon: String,
        title: String,
        message: String,
        @ViewBuilder action: @escaping () -> Action = { EmptyView() }
    ) {
        self.icon = icon
        self.title = title
        self.message = message
        self.action = action
    }

    var body: some View {
        VStack(spacing: 14) {
            Image(systemName: icon)
                .font(.system(size: 44))
                .foregroundStyle(.white.opacity(0.25))

            Text(title)
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(.white.opacity(0.8))

            Text(message)
                .font(.system(size: 14))
                .foregroundStyle(.white.opacity(Design.secondaryTextOpacity))
                .multilineTextAlignment(.center)

            action()
                .padding(.top, 6)
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 100)
        .padding(.horizontal, 32)
    }
}

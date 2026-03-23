// Presentation/Components/CachedAsyncImage.swift

import SwiftUI

struct CachedAsyncImage<Content: View, Placeholder: View>: View {
    private let url: URL?
    private let content: (Image) -> Content
    private let placeholder: () -> Placeholder
    private let onLoaded: (() -> Void)?

    @State private var loadedImage: UIImage? = nil

    init(
        url: URL?,
        onLoaded: (() -> Void)? = nil,
        @ViewBuilder content: @escaping (Image) -> Content,
        @ViewBuilder placeholder: @escaping () -> Placeholder
    ) {
        self.url = url
        self.onLoaded = onLoaded
        self.content = content
        self.placeholder = placeholder
    }

    var body: some View {
        Group {
            if let loadedImage {
                content(Image(uiImage: loadedImage))
            } else {
                placeholder()
            }
        }
        .task(id: url) {
            loadedImage = await fetchImage()
            if loadedImage != nil {
                onLoaded?()
            }
        }
    }

    private func fetchImage() async -> UIImage? {
        guard let url else { return nil }

        let request = URLRequest(url: url)

        // Check cache first — no network call if cached
        if let cached = ImageCache.cache.cachedResponse(for: request),
           let image = UIImage(data: cached.data) {
            return image
        }

        // Not cached — fetch using the session wired to our cache
        guard let (data, response) = try? await ImageCache.session.data(for: request),
              let image = UIImage(data: data) else {
            return nil
        }

        let cachedResponse = CachedURLResponse(response: response, data: data)
        ImageCache.cache.storeCachedResponse(cachedResponse, for: request)

        return image
    }
}

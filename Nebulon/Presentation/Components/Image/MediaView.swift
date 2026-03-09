//
//  MediaView.swift
//  Nebulon
//
//  Created by Oto Sharvashidze on 08.03.26.
//


// Presentation/Components/MediaView.swift

import SwiftUI

struct MediaView: View {
    let url: String
    let isVideo: Bool

    var body: some View {
        if isVideo {
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
            CachedAsyncImage(
                url: URL(string: url)
            ) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                Rectangle().fill(.gray.opacity(0.2))
            }
        }
    }
}
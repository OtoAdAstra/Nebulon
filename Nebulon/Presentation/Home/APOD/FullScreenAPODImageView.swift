//
//  FullScreenAPODImageView.swift
//  Nebulon
//
//  Created by Oto Sharvashidze on 11.03.26.
//

import SwiftUI

struct FullScreenAPODImageView: View {
    let url: String
    @Environment(\.dismiss) private var dismiss
    @State private var scale: CGFloat = 1.0
    @State private var lastScale: CGFloat = 1.0
    @State private var offset: CGSize = .zero

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            CachedAsyncImage(url: URL(string: url)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .scaleEffect(scale)
                    .offset(offset)
                    .gesture(
                        MagnifyGesture()
                            .onChanged { value in
                                scale = lastScale * value.magnification
                            }
                            .onEnded { _ in
                                lastScale = max(1.0, scale)
                                if scale < 1.0 {
                                    withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                                        scale = 1.0
                                        lastScale = 1.0
                                    }
                                }
                            }
                    )
                    .simultaneousGesture(
                        DragGesture()
                            .onChanged { value in
                                if scale <= 1.0 {
                                    offset = value.translation
                                }
                            }
                            .onEnded { value in
                                if scale <= 1.0 && abs(value.translation.height) > 100 {
                                    dismiss()
                                } else {
                                    withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                                        offset = .zero
                                    }
                                }
                            }
                    )
            } placeholder: {
                ProgressView()
                    .tint(.white)
            }

            // Close button
            VStack {
                HStack {
                    Spacer()
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.title)
                            .foregroundStyle(.white.opacity(0.7))
                            .padding()
                    }
                }
                Spacer()
            }
        }
        .background(.black)
    }
}

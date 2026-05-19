import SwiftUI

/// Wraps any view with a left-edge swipe-to-dismiss gesture.
/// Pair with `.transition(.move(edge: .trailing))` for a slide-in-from-right + swipe-back-to-dismiss flow.
struct NavigationContainer<Content: View>: View {
    let onDismiss: () -> Void
    @ViewBuilder let content: () -> Content

    @State private var dragOffset: CGFloat = 0

    private let edgeWidth: CGFloat = 30
    private let dismissThreshold: CGFloat = 100
    private let velocityThreshold: CGFloat = 500
    private let dismissDuration: CGFloat = 0.25

    var body: some View {
        let screenWidth = UIScreen.main.bounds.width

        ZStack(alignment: .leading) {
            content()
                .offset(x: dragOffset)
                .overlay(alignment: .topLeading) {
                    DismissButton("chevron.left") { onDismiss() }
                }

            Color.clear
                .frame(width: edgeWidth)
                .contentShape(Rectangle())
                .gesture(
                    DragGesture(minimumDistance: 5)
                        .onChanged { value in
                            if value.translation.width > 0 {
                                dragOffset = value.translation.width
                            }
                        }
                        .onEnded { value in
                            let shouldDismiss = value.translation.width > dismissThreshold
                                || value.velocity.width > velocityThreshold

                            if shouldDismiss {
                                withAnimation(.easeOut(duration: dismissDuration)) {
                                    dragOffset = screenWidth
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + dismissDuration) {
                                    onDismiss()
                                }
                            } else {
                                withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                                    dragOffset = 0
                                }
                            }
                        }
                )
        }
    }
}

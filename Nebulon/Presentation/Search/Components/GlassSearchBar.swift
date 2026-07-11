import SwiftUI

struct GlassSearchBar: View {
    @Binding var text: String
    var placeholder: String = "Search the cosmos"

    @FocusState private var isFocused: Bool

    var body: some View {
        if #available(iOS 26, *) {
            GlassEffectContainer(spacing: Design.itemSpacing) {
                barContent
            }
        } else {
            barContent
        }
    }

    private var barContent: some View {
        HStack(spacing: Design.itemSpacing) {
            searchField

            if isFocused {
                cancelButton
                    .transition(.move(edge: .trailing).combined(with: .opacity))
            }
        }
        .animation(.spring(response: 0.3, dampingFraction: 0.9), value: isFocused)
    }

    // MARK: - Field

    private var searchField: some View {
        HStack(spacing: 8) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 16, weight: .medium))
                .foregroundStyle(.white.opacity(Design.secondaryTextOpacity))

            TextField("", text: $text, prompt: prompt)
                .focused($isFocused)
                .foregroundStyle(.white)
                .tint(Color("LightCyan"))
                .submitLabel(.search)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)

            if !text.isEmpty {
                Button {
                    text = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 16))
                        .foregroundStyle(.white.opacity(Design.secondaryTextOpacity))
                }
                .buttonStyle(.plain)
                .transition(.scale.combined(with: .opacity))
            }
        }
        .animation(.easeInOut(duration: 0.15), value: text.isEmpty)
        .padding(.horizontal, Design.searchFieldPadding)
        .frame(height: Design.searchBarHeight)
        .modifier(GlassSearchBarBackground())
    }

    private var prompt: Text {
        Text(placeholder)
            .foregroundStyle(.white.opacity(Design.secondaryTextOpacity))
    }

    private var cancelButton: some View {
        Button {
            text = ""
            isFocused = false
        } label: {
            Image(systemName: "xmark")
                .font(.system(size: 15, weight: .semibold))
                .foregroundStyle(.white)
                .frame(width: Design.searchBarHeight, height: Design.searchBarHeight)
                .contentShape(Circle())
                .modifier(GlassCircleBackground())
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Field Background

private struct GlassSearchBarBackground: ViewModifier {
    func body(content: Content) -> some View {
        if #available(iOS 26, *) {
            content
                .glassEffect(.regular, in: Capsule())
        } else {
            content
                .background {
                    Capsule()
                        .fill(.ultraThinMaterial)
                        .overlay {
                            Capsule()
                                .stroke(
                                    .white.opacity(Design.glassStrokeOpacity),
                                    lineWidth: Design.glassStrokeWidth
                                )
                        }
                }
        }
    }
}

// MARK: - Round Glass Button Background

private struct GlassCircleBackground: ViewModifier {
    func body(content: Content) -> some View {
        if #available(iOS 26, *) {
            content
                .glassEffect(.regular.interactive(), in: Circle())
        } else {
            content
                .background {
                    Circle()
                        .fill(.ultraThinMaterial)
                        .overlay {
                            Circle()
                                .stroke(
                                    .white.opacity(Design.glassStrokeOpacity),
                                    lineWidth: Design.glassStrokeWidth
                                )
                        }
                }
        }
    }
}

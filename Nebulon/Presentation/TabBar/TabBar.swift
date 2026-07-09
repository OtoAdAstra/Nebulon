import SwiftUI

struct TabBar: View {
    @Binding var selectedTab: Tabs
    @Namespace private var namespace

    var body: some View {
        HStack(spacing: 0) {
            ForEach(Tabs.allCases, id: \.self) { tab in
                tabButton(tab)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .animation(.spring(response: 0.2, dampingFraction: 0.7), value: selectedTab)
        .modifier(TabBarBackground())
        .padding(.horizontal, 14)
        .frame(maxWidth: .infinity)
        .contentShape(Rectangle())
    }

    private func tabButton(_ tab: Tabs) -> some View {
        Button {
            selectedTab = tab
        } label: {
            ZStack {
                if selectedTab == tab {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(LinearGradient(
                            colors: [
                                Color("LightSpace").opacity(0.6),
                                Color.purple.opacity(0.3)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ))
                        .frame(width: 58, height: 58)
                        .matchedGeometryEffect(id: "tab_selection", in: namespace)
                }
                VStack(spacing: 4) {
                    Image(systemName: tab.icon)
                        .font(.system(size: 22, weight: selectedTab == tab ? .bold : .regular))
                        .foregroundStyle(selectedTab == tab ? Color("LightCyan") : .white.opacity(0.4))
                        .scaleEffect(selectedTab == tab ? 1.1 : 1.0)

                    Text(tab.label)
                        .font(.system(size: 12, weight: .medium))
                        .foregroundStyle(selectedTab == tab ? .white : .white.opacity(0.4))
                        .fixedSize(horizontal: true, vertical: false)
                }
                .frame(width: 44, height: 32)
            }
            .contentShape(Rectangle())
        }
        .frame(maxWidth: .infinity)
        .buttonStyle(.plain)
    }
}

// MARK: - Background

private struct TabBarBackground: ViewModifier {
    private let cornerRadius: CGFloat = 30

    func body(content: Content) -> some View {
        if #available(iOS 26, *) {
            content
                .glassEffect(
                    .regular,
                    in: RoundedRectangle(cornerRadius: cornerRadius)
                )
        } else {
            content
                .background {
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .fill(.ultraThinMaterial)
                        .blur(radius: 2)
                        .overlay {
                            RoundedRectangle(cornerRadius: cornerRadius)
                                .stroke(.white.opacity(0.2), lineWidth: 0.3)
                        }
                }
        }
    }
}

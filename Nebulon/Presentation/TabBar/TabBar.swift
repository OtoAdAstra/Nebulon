//
//  CosmicTabBar.swift
//  Nebulon
//
//  Created by Oto Sharvashidze on 04.03.26.
//


// Presentation/TabBar/CosmicTabBar.swift

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
        .background {
            // Glassmorphism background
            RoundedRectangle(cornerRadius: 30)
                .fill(.ultraThinMaterial)
                .overlay {
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(
                            LinearGradient(
                                colors: [.white.opacity(0.3), .clear],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 1
                        )
                }
                .shadow(color: .black.opacity(0.3), radius: 20, y: 10)
        }
        .padding(.horizontal, 24)
    }

    private func tabButton(_ tab: Tabs) -> some View {
        Button {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                selectedTab = tab
            }
        } label: {
            VStack(spacing: 4) {
                ZStack {
                    // Animated selection pill
                    if selectedTab == tab {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(.white.opacity(0.15))
                            .frame(width: 44, height: 32)
                            .matchedGeometryEffect(id: "tab_selection", in: namespace)
                    }

                    Image(systemName: tab.icon)
                        .font(.system(size: 18, weight: selectedTab == tab ? .bold : .regular))
                        .foregroundStyle(selectedTab == tab ? .white : .white.opacity(0.4))
                        .scaleEffect(selectedTab == tab ? 1.1 : 1.0)
                }
                .frame(width: 44, height: 32)

                Text(tab.label)
                    .font(.system(size: 9, weight: .medium))
                    .foregroundStyle(selectedTab == tab ? .white : .white.opacity(0.4))
            }
        }
        .frame(maxWidth: .infinity)
        .buttonStyle(.plain)
    }
}

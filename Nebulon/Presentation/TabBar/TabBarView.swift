//
//  CustomTabBarView.swift
//  Nebulon
//
//  Created by Oto Sharvashidze on 04.03.26.
//


// Presentation/TabBar/CustomTabBarView.swift

// Presentation/TabBar/TabBarView.swift

import SwiftUI

struct TabBarView: View {
    @Bindable var coordinator: AppCoordinator

    var body: some View {
        ZStack(alignment: .bottom) {
            Group {
                switch coordinator.selectedTab {
                case .home:
                    // ✅ same VM every time — coordinator owns it
                    HomeView(viewModel: coordinator.apodViewModel)
                case .explore:
                    Text("Explore").foregroundStyle(.white)
                case .mars:
                    Text("Mars").foregroundStyle(.white)
                case .neo:
                    Text("NEOs").foregroundStyle(.white)
                case .ar:
                    Text("AR").foregroundStyle(.white)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            TabBar(selectedTab: $coordinator.selectedTab)
                .padding(.bottom, 24)
        }
        .background(.black)
        .ignoresSafeArea()
    }
}

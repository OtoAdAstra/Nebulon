//
//  NebulonApp.swift
//  Nebulon
//
//  Created by Oto Sharvashidze on 01.03.26.
//

import SwiftUI

@main
struct NebulonApp: App {
    private let container = DIContainer()
    
    var body: some Scene {
        WindowGroup {
            AppRootView(container: container)
                .preferredColorScheme(.dark)
        }
    }
}

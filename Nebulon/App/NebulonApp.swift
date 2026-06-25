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

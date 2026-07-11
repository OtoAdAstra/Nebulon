import SwiftUI

extension View {
    func header() -> some View {
        self.font(.system(size: 18, weight: .bold, design: .monospaced))
            .tracking(1.2)
            .foregroundStyle(.white.opacity(0.45))
    }
}

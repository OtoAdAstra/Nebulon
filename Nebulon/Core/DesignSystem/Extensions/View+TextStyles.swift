import SwiftUI

extension View {
    func header() -> some View {
        self.font(Design.sectionHeaderFont)
            .tracking(1.2)
            .foregroundStyle(.white.opacity(0.45))
    }
}

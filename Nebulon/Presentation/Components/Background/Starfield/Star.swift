import Foundation
internal import CoreGraphics

struct Star: Identifiable {
    let id = UUID()
    var x: CGFloat
    var y: CGFloat
    let size: CGFloat
    let opacity: Double
    let speed: CGFloat
    let twinklePhase: Double
}

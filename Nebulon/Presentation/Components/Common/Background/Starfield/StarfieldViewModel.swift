import Foundation
internal import CoreGraphics

// MARK: - Star Model
struct Star: Identifiable {
    let id = UUID()
    var x: CGFloat
    var y: CGFloat
    let size: CGFloat
    let opacity: Double
    let speed: CGFloat
    let twinklePhase: Double
}

// MARK: - ViewModel
@Observable
final class StarfieldViewModel {
    private(set) var stars: [Star] = []
    private var screenSize: CGSize = .zero

    func setup(size: CGSize, count: Int = 150) {
        guard stars.isEmpty || screenSize != size else { return }
        screenSize = size
        stars = (0..<count).map { _ in makeStar(randomY: true) }
    }

    func tick(delta: TimeInterval) {
        for i in stars.indices {
            stars[i].y += stars[i].speed * CGFloat(delta)
            if stars[i].y > 1.05 {
                stars[i] = makeStar(randomY: false)
            }
        }
    }

    private func makeStar(randomY: Bool) -> Star {
        Star(
            x: CGFloat.random(in: 0...1),
            y: randomY ? CGFloat.random(in: -0.05...1.05) : CGFloat.random(in: -0.05 ... -0.01),
            size: CGFloat.random(in: 0.5...2.2),
            opacity: Double.random(in: 0.15...0.65),
            speed: CGFloat.random(in: 0.008...0.025),
            twinklePhase: Double.random(in: 0...(2 * .pi))
        )
    }
}

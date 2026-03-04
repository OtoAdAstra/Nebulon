import SwiftUI

// MARK: - Canvas View
private struct StarfieldCanvas: View {
    @Bindable var vm: StarfieldViewModel
    let time: TimeInterval

    var body: some View {
        GeometryReader { geo in
            Canvas { ctx, size in
                for star in vm.stars {
                    let twinkle = (sin(time * 1.4 + star.twinklePhase) + 1) / 2
                    let finalOpacity = star.opacity * (0.6 + 0.4 * twinkle)

                    let px = star.x * size.width
                    let py = star.y * size.height
                    let rect = CGRect(
                        x: px - star.size / 2,
                        y: py - star.size / 2,
                        width: star.size,
                        height: star.size
                    )

                    let glowRect = rect.insetBy(dx: -star.size * 1.5, dy: -star.size * 1.5)
                    ctx.fill(
                        Path(ellipseIn: glowRect),
                        with: .color(.white.opacity(finalOpacity * 0.15))
                    )

                    ctx.fill(
                        Path(ellipseIn: rect),
                        with: .color(.white.opacity(finalOpacity))
                    )
                }
            }
            .onAppear { vm.setup(size: geo.size) }
            .onChange(of: geo.size) { _, new in vm.setup(size: new) }
        }
    }
}

// MARK: - Public Background View
public struct StarfieldBackground: View {

    @State private var vm = StarfieldViewModel()
    @State private var previousTime: TimeInterval = 0

    public init() {}

    public var body: some View {
        ZStack {
            LinearGradient(
                stops: [
                    .init(color: Color(red: 0x0B/255, green: 0x0F/255, blue: 0x1A/255), location: 0),
                    .init(color: Color(red: 0x0B/255, green: 0x0F/255, blue: 0x1A/255), location: 0.5),
                    .init(color: Color(red: 0x0B/255, green: 0x0F/255, blue: 0x1A/255), location: 1),
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            
            TimelineView(.animation) { timeline in
                let time = timeline.date.timeIntervalSinceReferenceDate
                StarfieldCanvas(vm: vm, time: time)
                    .onChange(of: time) { _, new in
                        let delta = previousTime == 0 ? 0 : new - previousTime
                        previousTime = new
                        vm.tick(delta: delta)
                    }
            }
        }
        .ignoresSafeArea()
    }
}

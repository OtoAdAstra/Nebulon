import SwiftUI

struct Planet: Identifiable, Hashable {
    let id: String
    let name: String
    let modelName: String
    let subtitle: String
    let color: Color
    let ringColor: Color?
    let size: CGFloat
    let orbitIndex: Int

    let description: String
    let diameter: String
    let distanceFromSun: String
    let dayLength: String
    let yearLength: String
    let moons: Int
    let temperature: String

    var hasRing: Bool { ringColor != nil }
}

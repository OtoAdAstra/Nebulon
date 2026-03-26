// Domain/Entities/Planet.swift

import SwiftUI

struct Planet: Identifiable, Hashable {
    let id: String
    let name: String
    let subtitle: String
    let color: Color
    let ringColor: Color?
    let size: CGFloat        // Relative scale (0...1)
    let orbitIndex: Int      // Position from the sun

    var hasRing: Bool { ringColor != nil }

    static let allPlanets: [Planet] = [
        Planet(id: "mercury", name: "Mercury", subtitle: "Closest to Sun",
               color: Color(red: 0.6, green: 0.55, blue: 0.5), ringColor: nil,
               size: 0.35, orbitIndex: 0),
        Planet(id: "venus", name: "Venus", subtitle: "Morning Star",
               color: Color(red: 0.9, green: 0.7, blue: 0.4), ringColor: nil,
               size: 0.55, orbitIndex: 1),
        Planet(id: "earth", name: "Earth", subtitle: "Your Home",
               color: Color(red: 0.2, green: 0.5, blue: 0.9), ringColor: nil,
               size: 0.58, orbitIndex: 2),
        Planet(id: "mars", name: "Mars", subtitle: "Red Planet",
               color: Color(red: 0.85, green: 0.35, blue: 0.2), ringColor: nil,
               size: 0.42, orbitIndex: 3),
        Planet(id: "jupiter", name: "Jupiter", subtitle: "Gas Giant",
               color: Color(red: 0.8, green: 0.65, blue: 0.45), ringColor: nil,
               size: 1.0, orbitIndex: 4),
        Planet(id: "saturn", name: "Saturn", subtitle: "Ringed Beauty",
               color: Color(red: 0.85, green: 0.75, blue: 0.5), ringColor: Color(red: 0.9, green: 0.8, blue: 0.55),
               size: 0.9, orbitIndex: 5),
        Planet(id: "uranus", name: "Uranus", subtitle: "Ice Giant",
               color: Color(red: 0.55, green: 0.8, blue: 0.85), ringColor: Color(red: 0.65, green: 0.85, blue: 0.9),
               size: 0.7, orbitIndex: 6),
        Planet(id: "neptune", name: "Neptune", subtitle: "Windiest Planet",
               color: Color(red: 0.25, green: 0.4, blue: 0.9), ringColor: nil,
               size: 0.68, orbitIndex: 7),
        Planet(id: "pluto", name: "Pluto", subtitle: "My Home",
               color: Color(red: 0.7, green: 0.65, blue: 0.6), ringColor: nil,
               size: 0.25, orbitIndex: 8),
    ]
}

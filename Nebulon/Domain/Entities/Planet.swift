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

    // Detail info
    let description: String
    let diameter: String         // km
    let distanceFromSun: String  // million km
    let dayLength: String        // Earth hours/days
    let yearLength: String       // Earth days/years
    let moons: Int
    let temperature: String      // average surface temp

    var hasRing: Bool { ringColor != nil }

    static let allPlanets: [Planet] = [
        Planet(id: "mercury", name: "Mercury", subtitle: "Closest to Sun",
               color: Color(red: 0.6, green: 0.55, blue: 0.5), ringColor: nil,
               size: 0.35, orbitIndex: 0,
               description: "Mercury is the smallest planet in our solar system and nearest to the Sun. It has a cratered surface similar to Earth's Moon, virtually no atmosphere, and extreme temperature swings between day and night.",
               diameter: "4,879", distanceFromSun: "57.9", dayLength: "1,408 hours", yearLength: "88 days",
               moons: 0, temperature: "167°C"),
        Planet(id: "venus", name: "Venus", subtitle: "Morning Star",
               color: Color(red: 0.9, green: 0.7, blue: 0.4), ringColor: nil,
               size: 0.55, orbitIndex: 1,
               description: "Venus is the second planet from the Sun and the hottest planet in our solar system. Its thick, toxic atmosphere traps heat in a runaway greenhouse effect, making it an extreme example of climate change.",
               diameter: "12,104", distanceFromSun: "108.2", dayLength: "5,832 hours", yearLength: "225 days",
               moons: 0, temperature: "464°C"),
        Planet(id: "earth", name: "Earth", subtitle: "Your Home",
               color: Color(red: 0.2, green: 0.5, blue: 0.9), ringColor: nil,
               size: 0.58, orbitIndex: 2,
               description: "Earth is the third planet from the Sun and the only known world to harbor life. About 71% of its surface is covered in water, and it has a protective magnetic field and atmosphere that sustain a rich biosphere.",
               diameter: "12,756", distanceFromSun: "149.6", dayLength: "24 hours", yearLength: "365.25 days",
               moons: 1, temperature: "15°C"),
        Planet(id: "mars", name: "Mars", subtitle: "Red Planet",
               color: Color(red: 0.85, green: 0.35, blue: 0.2), ringColor: nil,
               size: 0.42, orbitIndex: 3,
               description: "Mars is the fourth planet from the Sun and is known as the Red Planet due to iron oxide on its surface. It hosts the tallest volcano and the deepest canyon in the solar system — Olympus Mons and Valles Marineris.",
               diameter: "6,792", distanceFromSun: "227.9", dayLength: "24.6 hours", yearLength: "687 days",
               moons: 2, temperature: "-65°C"),
        Planet(id: "jupiter", name: "Jupiter", subtitle: "Gas Giant",
               color: Color(red: 0.8, green: 0.65, blue: 0.45), ringColor: nil,
               size: 1.0, orbitIndex: 4,
               description: "Jupiter is the largest planet in our solar system. Its iconic Great Red Spot is a storm larger than Earth that has raged for hundreds of years. Jupiter's massive gravity has shaped the architecture of the entire solar system.",
               diameter: "142,984", distanceFromSun: "778.6", dayLength: "9.9 hours", yearLength: "11.9 years",
               moons: 95, temperature: "-110°C"),
        Planet(id: "saturn", name: "Saturn", subtitle: "Ringed Beauty",
               color: Color(red: 0.85, green: 0.75, blue: 0.5), ringColor: Color(red: 0.9, green: 0.8, blue: 0.55),
               size: 0.9, orbitIndex: 5,
               description: "Saturn is the sixth planet from the Sun, famous for its stunning ring system made of ice and rock. Despite being the second-largest planet, it is the least dense — it would float if placed in a large enough body of water.",
               diameter: "120,536", distanceFromSun: "1,433.5", dayLength: "10.7 hours", yearLength: "29.4 years",
               moons: 146, temperature: "-140°C"),
        Planet(id: "uranus", name: "Uranus", subtitle: "Ice Giant",
               color: Color(red: 0.55, green: 0.8, blue: 0.85), ringColor: Color(red: 0.65, green: 0.85, blue: 0.9),
               size: 0.7, orbitIndex: 6,
               description: "Uranus is the seventh planet from the Sun and rotates on its side with an axial tilt of about 98 degrees. This ice giant has a blue-green color from methane in its atmosphere and a faint ring system.",
               diameter: "51,118", distanceFromSun: "2,872.5", dayLength: "17.2 hours", yearLength: "84 years",
               moons: 28, temperature: "-195°C"),
        Planet(id: "neptune", name: "Neptune", subtitle: "Windiest Planet",
               color: Color(red: 0.25, green: 0.4, blue: 0.9), ringColor: nil,
               size: 0.68, orbitIndex: 7,
               description: "Neptune is the eighth and most distant planet from the Sun. It has the strongest winds in the solar system, reaching speeds of over 2,000 km/h. Its vivid blue color comes from methane in its atmosphere.",
               diameter: "49,528", distanceFromSun: "4,495.1", dayLength: "16.1 hours", yearLength: "164.8 years",
               moons: 16, temperature: "-200°C"),
        Planet(id: "pluto", name: "Pluto", subtitle: "My Home",
               color: Color(red: 0.7, green: 0.65, blue: 0.6), ringColor: nil,
               size: 0.25, orbitIndex: 8,
               description: "Pluto is a dwarf planet in the Kuiper Belt. Once considered the ninth planet, it was reclassified in 2006. Despite its small size, Pluto has a complex surface with mountains, valleys, and a heart-shaped nitrogen ice plain.",
               diameter: "2,376", distanceFromSun: "5,906.4", dayLength: "153.3 hours", yearLength: "248 years",
               moons: 5, temperature: "-230°C"),
    ]
}

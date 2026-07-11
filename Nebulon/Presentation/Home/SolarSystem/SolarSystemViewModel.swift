import Foundation

@MainActor
@Observable
final class SolarSystemViewModel {
    let planets: [Planet] = Planet.allPlanets
}

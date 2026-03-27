// Presentation/Home/SolarSystem/SolarSystemViewModel.swift

import Foundation

@MainActor
@Observable
final class SolarSystemViewModel {
    let planets: [Planet] = Planet.allPlanets
}

// Presentation/Home/SolarSystem/SolarSystemViewModel.swift

import Foundation

@MainActor
@Observable
final class SolarSystemViewModel {
    let planets: [Planet] = Planet.allPlanets

    func onPlanetTapped(_ planet: Planet) {
        // TODO: Navigate to planet detail
        print("🪐 Tapped planet: \(planet.name)")
    }
}

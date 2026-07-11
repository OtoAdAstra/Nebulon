import SceneKit
import SwiftUI

struct Planet3DView: UIViewRepresentable {
    let planet: Planet

    func makeUIView(context: Context) -> SCNView {
        let scnView = SCNView()
        scnView.backgroundColor = .clear
        scnView.autoenablesDefaultLighting = true
        scnView.allowsCameraControl = true
        scnView.rendersContinuously = false

        guard let url = Bundle.main.url(forResource: planet.modelName, withExtension: nil) else {
            return scnView
        }

        if let scene = try? SCNScene(url: url) {
            scene.background.contents = UIColor.clear
            let rotation = SCNAction.rotateBy(x: 0, y: .pi * 2, z: 0, duration: 30)
            scene.rootNode.runAction(.repeatForever(rotation))
            scnView.scene = scene
        }

        return scnView
    }

    func updateUIView(_ uiView: SCNView, context: Context) {}
}

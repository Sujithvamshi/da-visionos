import SwiftUI
import RealityKit
import RealityKitContent

struct ImmersiveView: View {
    
    @State var selectedImage: String
    @Environment(\.openImmersiveSpace) private var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace
    @State private var showingAlert = false
    @State private var selectedEntity = ""
    var body: some View {
        RealityView { content in
            // Create and add entities to the RealityView
            let pictureEntity = createImmersivePicture(imageName: selectedImage)
            let cbr = create3DButton(at: SIMD3<Float>(-2.0, 0.0, 2.0), label: "Children Room")
            let mbr = create3DButton(at: SIMD3<Float>(2.0, 0.0, 2.0), label: "Master Room")
            let kitchen = create3DButton(at: SIMD3<Float>(-2.0, 0.0, -2.0), label: "Kitchen")
            let gbr = create3DButton(at: SIMD3<Float>(2.0, 0.0, 2.0), label: "Guest Room")
        
            content.add(cbr)
            content.add(mbr)
            content.add(kitchen)
            content.add(gbr)
            content.add(pictureEntity)
        }
        
        .gesture(TapGesture().targetedToAnyEntity().onEnded { value in
            print("Tapped entity name: \(value.entity.name)")
            showingAlert = true
        })
    }

    func createImmersivePicture(imageName: String) -> Entity {
        let modelEntity = Entity()
        let texture = try? TextureResource.load(named: imageName)
        var material = UnlitMaterial()
        material.color = .init(texture: .init(texture!))
        modelEntity.components.set(ModelComponent(mesh: .generateSphere(radius: 1E3), materials: [material]))
        modelEntity.scale = .init(x: -1, y: 1, z: 1)
        modelEntity.transform.translation += SIMD3<Float>(-1.0, 1.0, 0.0)
        return modelEntity
    }

    func create3DButton(at position: SIMD3<Float>, label: String) -> Entity {
        let buttonEntity = ModelEntity(mesh: MeshResource.generateBox(size: 0.2, cornerRadius: 0.05))
        buttonEntity.name = label
        let textEntity = createText(label: label)
        buttonEntity.position = position
        buttonEntity.addChild(textEntity)
        buttonEntity.components.set(InputTargetComponent())
        buttonEntity.components.set(CollisionComponent(shapes: [.generateSphere(radius: 0.2)]))
        return buttonEntity
    }

    func createText(label: String) -> Entity {
        let textMesh = MeshResource.generateText(label, extrusionDepth: 0.02, font: .systemFont(ofSize: 0.1))
        let textEntity = ModelEntity(mesh: textMesh, materials: [SimpleMaterial(color: .white, isMetallic: false)])
        textEntity.position = SIMD3<Float>(0, 0.15, 0)
        return textEntity
    }
}

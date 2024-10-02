import SwiftUI

struct SceneDetailView: View {
    @State var daScene: DAScene
    @Binding var selectedImage: String
    @Environment(\.openImmersiveSpace) private var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace
    
    var body: some View {
        VStack {
            Image(daScene.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(20)
                .clipped()
                .shadow(radius: 10)
            
            Text(daScene.sceneName)
                .font(.headline)
                .padding(.top, 8)
        }
        .padding()
        .contentShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
        .hoverEffect(.lift)
        .onTapGesture {
            selectedImage = daScene.imageName
            Task{
                print("Changed")
                await dismissImmersiveSpace()
                await openImmersiveSpace(id: "ImmersiveSpace")
            }
        }
    }
}

//
//  ContentView.swift
//  Design Alley
//
//  Created by sujith vamshi on 02/10/24.
//

import SwiftUI
import RealityKit

struct ContentView: View {
    
    @Binding var selectedImage: String
    
    var tour1 :Tour
    var tour2 :Tour
    var tours: [Tour]
    @Environment(\.openImmersiveSpace) private var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace
    @State private var immersiveSpaceActive: Bool = false
    
    init(selectedImage: Binding<String>){
        self._selectedImage = selectedImage
        tour1 = Tour(
            tourName: "Design Alley Tour 1",
            scenes: [
                DAScene(imageName: "Living", sceneName: "Living Room", description: "This is Living Room"),
                DAScene(imageName: "Kitchen", sceneName: "Kitchen", description: "This is Kitchen"),
                DAScene(imageName: "Dining", sceneName: "Dining Room", description: "This is Dining Room"),
                DAScene(imageName: "MBR", sceneName: "Master Bedroom", description: "This is Master Bedroom"),
                DAScene(imageName: "CBR", sceneName: "Children Bedroom", description: "This is Children Bedroom"),
                DAScene(imageName: "GBR", sceneName: "Guest Bedroom", description: "This is Guest Bedroom")]
        )
        tour2 = Tour(
            tourName: "Design Alley Tour 2",
            scenes: [
                DAScene(imageName: "Living Room", sceneName: "Living Room", description: "This is Living Room"),
                DAScene(imageName: "Pooja Room", sceneName: "Pooja Room", description: "This is Pooja Room"),
                DAScene(imageName: "MBR 1", sceneName: "Master Bedroom", description: "This is Master Bedroom"),
                DAScene(imageName: "Kitchen 1", sceneName: "Kitchen", description: "This is Kitchen"),
                DAScene(imageName: "CBR 1", sceneName: "Children Bedroom", description: "This is Children Bedroom"),
                DAScene(imageName: "Table", sceneName: "Table View", description: "This is Table View"),
                DAScene(imageName: "GBR 1", sceneName: "Guest Bedroom", description: "This is Guest Bedroom")]
        )
        tours = [tour1,tour2]
    }
    var body: some View {
        NavigationSplitView {
            List {
                Button(immersiveSpaceActive ? "Exit Environment" : "View Environment") {
                    Task {
                        if !immersiveSpaceActive {
                            await openImmersiveSpace(id: "ImmersiveSpace")
                            immersiveSpaceActive = true
                        } else {
                            await dismissImmersiveSpace()
                            immersiveSpaceActive = false
                        }
                    }
                }
                .padding()
                .background(immersiveSpaceActive ? Color.black : Color.clear)
                .cornerRadius(10)
                ForEach(tours) { tour in
                    NavigationLink(destination: TourDetailView(tour:tour,selectedImage: $selectedImage)){
                        Text(tour.tourName)
                    }
                }
                .navigationTitle("Tours")
            }
        } detail: {
            Text("Select a scene to view details")
                .foregroundColor(.gray)
        }
    }
}

import SwiftUI
import RealityKit

struct ContentView: View {
    
    @Binding var selectedImage: String
    
    var tours: [Tour]
    @Environment(\.openImmersiveSpace) private var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace
    @State private var immersiveSpaceActive: Bool = false
    @State private var selectedTour: Tour?
    @State private var isLoading: Bool = false

    init(selectedImage: Binding<String>) {
        self._selectedImage = selectedImage
        let tour1 = Tour(
            tourName: "Design Alley Tour 1",
            floors: [""],
            scenes: [[
                DAScene(imageName: "Living", sceneName: "Living Room", description: "This is Living Room"),
                DAScene(imageName: "Kitchen", sceneName: "Kitchen", description: "This is Kitchen"),
                DAScene(imageName: "Dining", sceneName: "Dining Room", description: "This is Dining Room"),
                DAScene(imageName: "MBR", sceneName: "Master Bedroom", description: "This is Master Bedroom"),
                DAScene(imageName: "CBR", sceneName: "Children Bedroom", description: "This is Children Bedroom"),
                DAScene(imageName: "GBR", sceneName: "Guest Bedroom", description: "This is Guest Bedroom")]]
        )
        let tour2 = Tour(
            tourName: "Design Alley Tour 2",
            floors: [""],
            scenes: [[
                DAScene(imageName: "Living Room", sceneName: "Living Room", description: "This is Living Room"),
                DAScene(imageName: "Pooja Room", sceneName: "Pooja Room", description: "This is Pooja Room"),
                DAScene(imageName: "MBR 1", sceneName: "Master Bedroom", description: "This is Master Bedroom"),
                DAScene(imageName: "Kitchen 1", sceneName: "Kitchen", description: "This is Kitchen"),
                DAScene(imageName: "CBR 1", sceneName: "Children Bedroom", description: "This is Children Bedroom"),
                DAScene(imageName: "Table", sceneName: "Table View", description: "This is Table View"),
                DAScene(imageName: "GBR 1", sceneName: "Guest Bedroom", description: "This is Guest Bedroom")]]
        )
        let tour3 = Tour(
            tourName: "Design Alley Tour 3",
            floors: [""],
            scenes: [
                [DAScene(imageName: "TVUnitTour3", sceneName: "TV Unit", description: "This is TV Unit"),
                DAScene(imageName: "DiningTour3", sceneName: "Dining Room", description: "This is Dining Room"),
                DAScene(imageName: "CBRTour3", sceneName: "Children Bedroom", description: "This is Children Bedroom"),
                DAScene(imageName: "MBRTour3", sceneName: "Master Bedroom", description: "This is Master Bedroom"),
                DAScene(imageName: "KitchenTour3", sceneName: "Kitchen", description: "This is Kitchen"),
                DAScene(imageName: "GBRTour3", sceneName: "Guest Bedroom", description: "This is Guest Bedroom")]]
            
        )
        let tour4 = Tour(
            tourName: "Design Alley Tour 4",
            floors: ["Ground Floor","First Floor","Second Floor"],
            scenes: [
                [
                    DAScene(imageName: "GFDNGTour4", sceneName: "Dining Room", description: "This is TV Unit"),
                    DAScene(imageName: "GFFoyerTour4", sceneName: "Foyer", description: "This is TV Unit"),
                    DAScene(imageName: "GFGBRTour4", sceneName: "Guest Bedroom", description: "This is TV Unit"),
                    DAScene(imageName: "GFLVNGTour4", sceneName: "Living Room 1", description: "This is TV Unit"),
                    DAScene(imageName: "GFLVNG2Tour4", sceneName: "Living Room 2", description: "This is TV Unit"),
                    DAScene(imageName: "GFMBRTour4", sceneName: "Master Bedroom", description: "This is TV Unit"),
                    DAScene(imageName: "GFPujaTour4", sceneName: "Pooja Room", description: "This is TV Unit"),
                    DAScene(imageName: "GFSTAIRSTour4", sceneName: "Stairs", description: "This is TV Unit")
                ],[
                    DAScene(imageName: "FFCBRTour4", sceneName: "Children Bedroom", description: "This is TV Unit"),
                    DAScene(imageName: "FFCORRIDORTour4", sceneName: "Corridor", description: "This is Dining Room"),
                    DAScene(imageName: "FFLVNGTour4", sceneName: "Living Room", description: "This is Children Bedroom"),
                    DAScene(imageName: "FFMBRTour4", sceneName: "Master Bedroom", description: "This is Master Bedroom"),
                ],[
                    DAScene(imageName: "SFCMNTour4", sceneName: "Common Area", description: "This is Master Bedroom")
                ]
            ])
        self.tours = [tour1, tour2, tour3, tour4]
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
                        Button(action: {
                            switchTour(to: tour)
                        }) {
                            Text(tour.tourName)
                                .font(selectedTour?.id == tour.id ? .title : .headline)
                                .foregroundColor(selectedTour?.id == tour.id ? .blue : .primary)
                        }
                    }

                }
                .navigationTitle("Tours")
            } detail: {
                Group {
                    if isLoading {
                        VStack {
                           ProgressView()
                               .progressViewStyle(CircularProgressViewStyle())
                               .scaleEffect(2.0)
                           Text("Loading...")
                               .font(.headline)
                               .foregroundColor(.gray)
                               .padding(.top, 16)
                       }
                    } else if let tour = selectedTour {
                        TourDetailView(tour: tour, selectedImage: $selectedImage)
                            .id(tour.id)
                    } else {
                        Text("Select a tour to view details")
                            .foregroundColor(.gray)
                    }
                }
            }
        }
        
        private func switchTour(to newTour: Tour) {
            isLoading = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                selectedTour = newTour
                isLoading = false
            }
        }
}

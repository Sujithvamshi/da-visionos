//  TourDetailView.swift
//  Design Alley
//
//  Created by sujith vamshi on 09/10/24.
//

import SwiftUI

struct TourDetailView: View {
    
    @Environment(\.presentationMode) var presentationMode // To handle back navigation
    @State var tour: Tour
    @Binding var selectedImage: String
    
    let gridItems = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        ScrollView {
            ForEach(Array(tour.scenes.enumerated()), id: \.0) { index, daScenes in
                VStack(alignment: .leading) {
                    // Use the index to access the corresponding floor name
                    Text(tour.floors[index])
                        .font(.headline)
                        .padding(.bottom, 8)
                    
                    LazyVGrid(columns: gridItems, alignment: .center, spacing: 16) {
                        ForEach(daScenes) { daScene in
                            SceneDetailView(daScene: daScene, selectedImage: $selectedImage)
                        }
                    }
                }
                .padding([.top, .leading, .trailing], 16)
            }
        }
    }
}

//
//  TourDetailView.swift
//  Design Alley
//
//  Created by sujith vamshi on 09/10/24.
//
import SwiftUI

struct TourDetailView : View {
    
    @State var tour:Tour
    @Binding var selectedImage: String
    
    let gridItems = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    var body: some View {
        ScrollView {
            Text(tour.tourName)
                .font(.title)
                .padding(8)
            LazyVGrid(columns: gridItems, alignment: .center, spacing: 16) {
                ForEach(tour.scenes){ daScene in
                    SceneDetailView(daScene:daScene,selectedImage: $selectedImage)
                }
            }
            .padding()
        }
    }
}

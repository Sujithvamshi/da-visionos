//
//  Design_AlleyApp.swift
//  Design Alley
//
//  Created by sujith vamshi on 02/10/24.
//

import SwiftUI

@main
struct Design_AlleyApp: App {
    @State private var selectedImage: String = "DA"
    
    var body: some Scene {
        WindowGroup {
            ContentView(selectedImage: $selectedImage)
        }
        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView(selectedImage: selectedImage)
        }
        .immersionStyle(selection: .constant(.full), in: .full)
    }
}

//
//  Scene.swift
//  Design Alley
//
//  Created by sujith vamshi on 09/10/24.
//
import SwiftUI

struct DAScene: Identifiable ,Codable {
    var id = UUID()
    var imageName: String
    var sceneName: String
    var description: String
}

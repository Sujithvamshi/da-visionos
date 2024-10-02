//
//  Tour.swift
//  Design Alley
//
//  Created by sujith vamshi on 09/10/24.
//
import SwiftUI

struct Tour : Identifiable,Codable {
    var id = UUID()
    var tourName: String
    var scenes: [DAScene]
}

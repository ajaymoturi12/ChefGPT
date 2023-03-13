//
//  RecipeInfo.swift
//  ChefGPT
//
//  Created by Ajay Moturi on 3/13/23.
//

import Foundation

struct Results: Codable {
    var results: [RecipeInfo]
    var offset: Int
    var number: Int
    var totalResults: Int
}

struct RecipeInfo: Identifiable, Codable {
    var id: Int
    var title: String
    var image: String
    var imageType: String
}

//struct Recipe: Identifiable, Codable {
//
//}

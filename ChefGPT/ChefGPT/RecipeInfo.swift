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

struct Recipe: Codable {
    var vegetarian: Bool
    var vegan: Bool
    var glutenFree: Bool
    var dairyFree: Bool
    var preparationMinutes: Int
    var cookingMinutes: Int
    var analyzedInstructions: [Instructions]
    var extendedIngredients: [ExtendedIngredients]
}

struct Instructions: Codable {
    var name: String
    var steps: [Steps]
}

struct Steps: Codable{
    var number: Int
    var step: String
    var ingredients : [Ingredients]
}

struct Ingredients: Codable {
    var name: String
    var image: String  // String for now
}

struct ExtendedIngredients: Codable {
    var name: String
    var amount: Double
    var unit: String
}

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
    
    static let exampleData = [
        Recipe(vegetarian: false, vegan: false, glutenFree: false, dairyFree: false, preparationMinutes: 4, cookingMinutes: 5, analyzedInstructions: [], extendedIngredients: ExtendedIngredients.exampleData),
        Recipe(vegetarian: false, vegan: false, glutenFree: false, dairyFree: false, preparationMinutes: 4, cookingMinutes: 5, analyzedInstructions: [], extendedIngredients: ExtendedIngredients.exampleData),
        Recipe(vegetarian: false, vegan: false, glutenFree: false, dairyFree: false, preparationMinutes: 4, cookingMinutes: 5, analyzedInstructions: [], extendedIngredients: ExtendedIngredients.exampleData),
    ]
}

struct Instructions: Codable {
    var name: String
    var steps: [Steps]
}

struct Steps: Codable{
    var number: Int
    var step: String
}

struct ExtendedIngredients: Codable {
    var name: String
    var amount: Double
    var unit: String
    
    static let exampleData = [
    ExtendedIngredients(name: "Apple", amount: 2, unit: "each"),
    ExtendedIngredients(name: "Flour", amount: 2, unit: "cups"),
    ExtendedIngredients(name: "Peanut Butter", amount: 2, unit: "cups"),
    ExtendedIngredients(name:"Penne", amount: 2, unit: "lbs"),
    ExtendedIngredients(name:"Rice", amount: 2, unit: "lbs"),
    ExtendedIngredients(name:"Butter", amount: 2, unit: "tbsp"),
    ExtendedIngredients(name:"Rice", amount: 2, unit: "lbs"),
    ExtendedIngredients(name:"Tortilla", amount: 4, unit: "each"),
    ExtendedIngredients(name:"Black Beans", amount: 2, unit: "cans")
    ]
}

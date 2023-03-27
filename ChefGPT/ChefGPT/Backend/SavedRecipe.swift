//
//  SavedRecipe.swift
//  ChefGPT
//
//  Created by Ethan Fox on 3/27/23.
//

import Foundation

struct SavedRecipe {
    
    let id: Int
    let name: String
    let foodImage: String
    let time: Int
    
    var vegetarian: Bool
    var vegan: Bool
    var glutenFree: Bool
    var dairyFree: Bool
    var preparationMinutes: Int
    var cookingMinutes: Int
    
    let ingredients: [ExtendedIngredients]
    
    let instructions: [Instructions]
    
    
    static let sampleIndividualData = SavedRecipe(id: 716429, name: "Peanut Butter Jelly", foodImage: "https://spoonacular.com/recipeImages/673463-312x231.jpg", time: 5, vegetarian: false, vegan: false, glutenFree: false, dairyFree: false, preparationMinutes: 5, cookingMinutes: 5, ingredients: [
        ExtendedIngredients(name: "Peanut Butter", amount: 2, unit: "oz"),
        ExtendedIngredients(name: "Jelly", amount: 2, unit: "oz"),
        ExtendedIngredients(name: "Bread", amount: 2, unit: "slices")
        ], instructions: instructions)
    
    static let sampleData = [
        SavedRecipe(id: 716429, name: "Peanut Butter Jelly", foodImage: "https://spoonacular.com/recipeImages/673463-312x231.jpg", time: 5, vegetarian: false, vegan: false, glutenFree: false, dairyFree: false, preparationMinutes: 5, cookingMinutes: 5, ingredients: [
        ExtendedIngredients(name: "Peanut Butter", amount: 2, unit: "oz"),
        ExtendedIngredients(name: "Jelly", amount: 2, unit: "oz"),
        ExtendedIngredients(name: "Bread", amount: 2, unit: "slices")
        ], instructions: instructions),
        SavedRecipe(id: 716429, name: "Peanut Butter Jelly", foodImage: "https://spoonacular.com/recipeImages/673463-312x231.jpg", time: 5, vegetarian: false, vegan: false, glutenFree: false, dairyFree: false, preparationMinutes: 5, cookingMinutes: 5, ingredients: [
        ExtendedIngredients(name: "Peanut Butter", amount: 2, unit: "oz"),
        ExtendedIngredients(name: "Jelly", amount: 2, unit: "oz"),
        ExtendedIngredients(name: "Bread", amount: 2, unit: "slices")
        ], instructions: instructions),
        SavedRecipe(id: 716429, name: "Peanut Butter Jelly", foodImage: "https://spoonacular.com/recipeImages/673463-312x231.jpg", time: 5, vegetarian: false, vegan: false, glutenFree: false, dairyFree: false, preparationMinutes: 5, cookingMinutes: 5, ingredients: [
        ExtendedIngredients(name: "Peanut Butter", amount: 2, unit: "oz"),
        ExtendedIngredients(name: "Jelly", amount: 2, unit: "oz"),
        ExtendedIngredients(name: "Bread", amount: 2, unit: "slices")
        ], instructions: instructions)
    ]
    
    
    static let instructions =
    [
    Instructions(name: "Construct Sandwich", steps: [
    Steps(number: 1, step: "Get Bread", ingredients: [ Ingredients(name: "Bread", image: "image name")])])
    ]
}

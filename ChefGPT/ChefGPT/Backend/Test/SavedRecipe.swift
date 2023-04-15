//
//  SavedRecipe.swift
//  ChefGPT
//
//  Created by Ethan Fox on 3/27/23.
//

import Foundation
import SwiftUI
import CoreData

class SavedRecipe: ObservableObject {
    let id: Int
    let name: String
    let foodImage: String
    @Published var isFavorited: Bool
    let vegetarian: Bool
    let vegan: Bool
    let glutenFree: Bool
    let dairyFree: Bool
    let preparationMinutes: Int
    let cookingMinutes: Int
    let ingredients: [Encodable_Extended_Ingredients]
    let instructions: [Encodable_Instructions]

    init(id:Int, name:String, foodImage:String, isFavorited:Bool, vegetarian:Bool, vegan:Bool, glutenFree:Bool, dairyFree:Bool, preparationMinutes:Int, cookingMinutes:Int, ingredients:[Encodable_Extended_Ingredients], instructions:[Encodable_Instructions]) {
        self.id = id
        self.name = name
        self.foodImage = foodImage
        self.isFavorited = isFavorited
        self.vegetarian = vegetarian
        self.vegan = vegan
        self.glutenFree = glutenFree
        self.dairyFree = dairyFree
        self.preparationMinutes = preparationMinutes
        self.cookingMinutes = cookingMinutes
        self.ingredients = ingredients
        self.instructions = instructions
    }
    
    init(internal_recipe: User_Recipe) {
        self.id = Int(internal_recipe.id)
        self.name = internal_recipe.name!
        self.foodImage = internal_recipe.foodImage!
        self.isFavorited = internal_recipe.isFavorited
        self.vegetarian = internal_recipe.vegetarian
        self.vegan = internal_recipe.vegan
        self.glutenFree = internal_recipe.glutenFree
        self.dairyFree = internal_recipe.dairyFree
        self.preparationMinutes = Int(internal_recipe.preparationMinutes)
        self.cookingMinutes = Int(internal_recipe.cookingMinutes)
        self.ingredients = internal_recipe.ingredients as! [Encodable_Extended_Ingredients]
        self.instructions = internal_recipe.instructions as! [Encodable_Instructions]
    }
    
    func to_User_Recipe(context: NSManagedObjectContext) -> User_Recipe {
        let new_recipe = User_Recipe(context: context)
        new_recipe.id = Int64(self.id)
        new_recipe.name = self.name
        new_recipe.foodImage = self.foodImage
        new_recipe.isFavorited = self.isFavorited
        new_recipe.vegetarian = self.vegetarian
        new_recipe.vegan = self.vegan
        new_recipe.glutenFree = self.glutenFree
        new_recipe.dairyFree = self.dairyFree
        new_recipe.preparationMinutes = Int16(self.preparationMinutes)
        new_recipe.cookingMinutes = Int16(self.cookingMinutes)
        new_recipe.ingredients = self.ingredients as NSObject
        new_recipe.instructions = self.instructions as NSObject
        
        return new_recipe
    }
    
    func toggleFavorited() {
        print("Bruh")
        isFavorited.toggle()
    }

    static let sampleIndividualData = SavedRecipe(id: 716429, name: "Peanut Butter Jelly", foodImage: "https://spoonacular.com/recipeImages/673463-312x231.jpg", isFavorited: false, vegetarian: false, vegan: false, glutenFree: false, dairyFree: false, preparationMinutes: 5, cookingMinutes: 5, ingredients: [
        Encodable_Extended_Ingredients(name: "Peanut Butter", amount: 2, unit: "oz"),
        Encodable_Extended_Ingredients(name: "Jelly", amount: 2, unit: "oz"),
        Encodable_Extended_Ingredients(name: "Bread", amount: 2, unit: "slices")
        ],
        instructions: [Encodable_Instructions(name: "instruction1", steps: [Encodable_Steps(number: 1, step: "step1")])])

    static let sampleData = [
        SavedRecipe(id: 716429, name: "Peanut Butter Jelly", foodImage: "https://spoonacular.com/recipeImages/673463-312x231.jpg", isFavorited: false, vegetarian: true, vegan: false, glutenFree: false, dairyFree: false, preparationMinutes: 5, cookingMinutes: 5, ingredients: [
            Encodable_Extended_Ingredients(name: "Peanut Butter", amount: 2, unit: "oz"),
            Encodable_Extended_Ingredients(name: "Jelly", amount: 2, unit: "oz"),
            Encodable_Extended_Ingredients(name: "Bread", amount: 2, unit: "slices")
            ],
            instructions: [Encodable_Instructions(name: "instruction1", steps: [Encodable_Steps(number: 1, step: "step1")])]),
        SavedRecipe(id: 696969, name: "Peanut Butter Jelly", foodImage: "https://spoonacular.com/recipeImages/673463-312x231.jpg", isFavorited: false, vegetarian: false, vegan: false, glutenFree: false, dairyFree: false, preparationMinutes: 5, cookingMinutes: 5, ingredients: [
            Encodable_Extended_Ingredients(name: "Peanut Butter", amount: 2, unit: "oz"),
            Encodable_Extended_Ingredients(name: "Jelly", amount: 2, unit: "oz"),
            Encodable_Extended_Ingredients(name: "Bread", amount: 2, unit: "slices")
            ],
            instructions: [Encodable_Instructions(name: "instruction1", steps: [Encodable_Steps(number: 1, step: "step1")])]),
        SavedRecipe(id: 420420, name: "Peanut Butter Jelly", foodImage: "https://spoonacular.com/recipeImages/673463-312x231.jpg", isFavorited: false, vegetarian: false, vegan: false, glutenFree: false, dairyFree: false, preparationMinutes: 5, cookingMinutes: 5, ingredients: [
            Encodable_Extended_Ingredients(name: "Peanut Butter", amount: 2, unit: "oz"),
            Encodable_Extended_Ingredients(name: "Jelly", amount: 2, unit: "oz"),
            Encodable_Extended_Ingredients(name: "Bread", amount: 2, unit: "slices")
            ],
            instructions: [Encodable_Instructions(name: "instruction1", steps: [Encodable_Steps(number: 1, step: "step1")])])
    ]
}

//
//  UserData.swift
//  ChefGPT
//
//  Created by Ethan Fox on 3/15/23.
//

import Foundation
import SwiftUI
import CoreData

class Model: ObservableObject {
    
    @Published var usersRecipes : [SavedRecipe] = fakeRecipes
    @Published var usersPantry = ExtendedIngredients.exampleData
    
    
    public static var fakeRecipes = SavedRecipe.sampleData
    public static var usersPantry = ExtendedIngredients.exampleData
    
    
    
    func removeFromPantry(item: ExtendedIngredients) {
        usersPantry.removeAll { ingredient in
            ingredient.name == item.name
        }
    }
    
    
    func addToPantry(item: ExtendedIngredients) {
        usersPantry.append(item)
    }
    
    func getUserIngredients() -> [String] {
        var ingredients : [String] = []
        for ingredient in self.usersPantry {
            ingredients.append(ingredient.name)
        }
        return ingredients
    }
    
    func addRecipe(recipe: SavedRecipe) {
        usersRecipes.append(recipe)
    }
    
    func saveRecipe(recipe: SavedRecipe, context: NSManagedObjectContext) {
        let _ = recipe.to_User_Recipe(context: context)
        try? context.save()
    }
    
    @FetchRequest(sortDescriptors: []) var recipes: FetchedResults<User_Recipe>
    func load_recipes(context: NSManagedObjectContext) {
        var recipes: [SavedRecipe] = []
        for recipe in recipes {
            recipes.append(recipe)
        }
        usersRecipes = recipes
    }
}

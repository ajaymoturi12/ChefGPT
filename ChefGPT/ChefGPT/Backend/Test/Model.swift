//
//  UserData.swift
//  ChefGPT
//
//  Created by Ethan Fox on 3/15/23.
//

import Foundation
import SwiftUI

class Model: ObservableObject {
    
    @Published var usersRecipes = SavedRecipe.sampleData // currently just fake data
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
    
    func saveRecipes() { // TODO: Method that just saves recipes to CoreData
        
    }
}

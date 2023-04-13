//
//  UserData.swift
//  ChefGPT
//
//  Created by Ethan Fox on 3/15/23.
//

import Foundation

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
}

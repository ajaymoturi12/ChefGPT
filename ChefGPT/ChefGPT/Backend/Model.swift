//
//  UserData.swift
//  ChefGPT
//
//  Created by Ethan Fox on 3/15/23.
//

import Foundation

class Model: ObservableObject {
    
    @Published var usersRecipes = SavedRecipe.sampleData // currently just fake data
    @Published var usersPantry = [ExtendedIngredients]()
    
    
    public static var fakeRecipes = SavedRecipe.sampleData
    public static var usersPantry = ExtendedIngredients.exampleData
}

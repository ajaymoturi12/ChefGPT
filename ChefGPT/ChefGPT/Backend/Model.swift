//
//  UserData.swift
//  ChefGPT
//
//  Created by Ethan Fox on 3/15/23.
//

import Foundation

class UserData: ObservableObject {
    
    @Published var pantry = [ExtendedIngredients]()
    @Published var recipe = [Recipe]()
    
}

//
//  ExploreView.swift
//  ChefGPT
//
//  Created by Ethan Fox on 3/13/23.
//

import SwiftUI

struct ExploreView: View {
    
    @EnvironmentObject var model: Model
    
    var body: some View {
        Color.green
            .task {
                do {
                    let recipes = try await SpoonacularReq().getRecipesGivenIngredients(ingredients: "", count: 2)
                    
                    print(recipes.first!)
                } catch {
                    print("error", error)
                }
                
            }
    }
}

struct ExploreView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreView()
    }
}

//
//  ContentView.swift
//  ChefGPT
//
//  Created by Ajay Moturi on 3/6/23.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var recipes: FetchedResults<User_Recipe>
    var body: some View {
//        MainView()
        VStack {
            List(recipes) { recipe in
                Text(recipe.name ?? "Unknown")
                Button("Remove") {
                    moc.delete(recipe)
                    try? moc.save()
                }
            }
        }

        Button("Add") {
            let recipe = SavedRecipe(id: 716429, name: "Peanut Butter Jelly", foodImage: "https://spoonacular.com/recipeImages/673463-312x231.jpg", isFavorited: false, vegetarian: false, vegan: false, glutenFree: false, dairyFree: false, preparationMinutes: 5, cookingMinutes: 5, ingredients: [
                Encodable_Extended_Ingredients(name: "Peanut Butter", amount: 2, unit: "oz"),
                Encodable_Extended_Ingredients(name: "Jelly", amount: 2, unit: "oz"),
                Encodable_Extended_Ingredients(name: "Bread", amount: 2, unit: "slices")
                ],
                instructions: [Encodable_Instructions(name: "instruction1", steps: [Encodable_Steps(number: 1, step: "step1")])])
            let saveable = recipe.to_User_Recipe(context: moc)
            try? moc.save()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

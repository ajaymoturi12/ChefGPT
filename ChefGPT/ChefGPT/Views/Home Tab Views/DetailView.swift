//
//  DetailView.swift
//  ChefGPT
//
//  Created by Andy Chen on 4/15/23.
//

import SwiftUI

struct DetailView: View {
    @State var recipe: SavedRecipe = SavedRecipe(id: 321, name: "Fried Chicken", foodImage: "https://spoonacular.com/recipeImages/673463-312x231.jpg", isFavorited: true, vegetarian: true, vegan: false, glutenFree: false, dairyFree: false, preparationMinutes: 30, cookingMinutes: 60, ingredients: [Encodable_Extended_Ingredients(name: "Egg", amount: 2, unit: "count"), Encodable_Extended_Ingredients(name: "Bread", amount: 2, unit: "loaves"), Encodable_Extended_Ingredients(name: "Chicken", amount: 2, unit: "loaves")], instructions: [
        Encodable_Instructions(name: "Make sandwich", steps: [
        Encodable_Steps(number: 1, step: "get bread"),
        Encodable_Steps(number: 2, step: "get peanut butter"),
        Encodable_Steps(number: 3, step: "bruh")
        ])
    ])
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ZStack {
            ScrollView {
                VStack {
                    imageSection
                        .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 10)
                    VStack(alignment:.leading, spacing: 16) {
                        titleSection
                        Divider()
                        ingredientSection
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    
                }
            }.ignoresSafeArea()
            VStack {
                HStack {
                    Button("Back") {
                        dismiss()
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(Color(red:96/255, green:96/255, blue:96/255)).foregroundColor(.white)
                    Spacer()
                }
                Spacer()
            }
            .padding()

        }
        .navigationBarBackButtonHidden(true)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}


extension DetailView {
    private var imageSection: some View {
        TabView {
            AsyncImage(url: URL(string: recipe.foodImage)) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.width)
                    .clipped()
            } placeholder: {
                Color.gray
            }
        }.frame(height: 290)
         .tabViewStyle(PageTabViewStyle())
    }
    
    private var titleSection: some View {
        VStack(alignment:.leading, spacing: 8) {
            Text(recipe.name)
                .font(.largeTitle)
                .fontWeight(.semibold)
            HStack{
                Text("Prep: \(String(recipe.preparationMinutes)) mins")
                Text("Cook: \(String(recipe.cookingMinutes)) mins")
            }
            .font(.title3)
            .foregroundColor(.secondary)
            
            Text("Missing Ingredients")
                .font(.title3)
                .fontWeight(.semibold)
            HStack() {
                Text("Milk")
                Text("Pasta")
                Text("Tomatoes")
            }
            .font(.title3)
            .foregroundColor(.secondary)
        }
    }
    
    private var ingredientSection: some View {
        
        VStack(alignment:.leading, spacing: 8) {
            Text("Ingredients: ")
                .font(.title)
                .fontWeight(.semibold)
            ForEach(recipe.ingredients, id: \.self) { ingredient in
                Text("• \(ingredient.name)")
            }
                .font(.body)
            Text("Instructions:")
                .font(.title)
                .fontWeight(.semibold)
            ForEach(recipe.instructions, id: \.self) { ingredient in
                    Text(ingredient.name)
                    .font(.title3)
                    .fontWeight(.semibold)
                    ForEach(ingredient.steps, id:\.self) { step in
                        Text("\(step.number). \(step.step)")
                    }
                    .font(.body)

            }
                
            
            
        }
    }
    
}

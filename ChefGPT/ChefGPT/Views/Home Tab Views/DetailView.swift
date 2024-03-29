//
//  DetailView.swift
//  ChefGPT
//
//  Created by Andy Chen on 4/15/23.
//

import SwiftUI

struct DetailView: View {
    @State var recipe: SavedRecipe
    
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
                    .tint(.white).foregroundColor(.black)
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
        DetailView(recipe: SavedRecipe.sampleIndividualData)
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

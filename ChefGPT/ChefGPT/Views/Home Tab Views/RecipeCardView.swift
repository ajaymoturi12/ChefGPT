//
//  RecipesCardView.swift
//  Card
//
//  Created by Andy Chen on 3/10/23.
//

import SwiftUI

struct RecipeCardView: View {
    
    @EnvironmentObject var recipe: SavedRecipe
    
    var body: some View {
        ZStack {
            VStack {
                AsyncImage(url: URL(string: recipe.foodImage)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 150)
                        .clipped()
                                    
                } placeholder: {
                    Color.gray
                        .frame(height: 150)
                }
                
                Image(recipe.foodImage)
                    
                HStack {
                    
                    VStack {
                        Text(recipe.name)
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding([.leading,.bottom])
                        
                        Text("Cooking Time : \(recipe.cookingMinutes + recipe.preparationMinutes) minutes")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding([.leading,.bottom])
//                            .foregroundColor(.secondary)
                    }
                    
                    HStack(alignment: .bottom) {
                        //classification icon;
                        if (recipe.dairyFree == true) {
                            Image(systemName: "drop.fill") //cant find a dairy icon
                                
                                .foregroundColor(.white)
                                .padding(10)
                                .background(.blue)
                                .clipShape(Circle())
                                .scaleEffect(0.5)
                                .frame(maxWidth: 15, alignment: .trailing)
                        }
                        if (recipe.vegetarian == true) {
                            Image(systemName: "leaf.fill")
                                
                                .foregroundColor(.white)
                                .padding(10)
                                .background(.green)
                                .clipShape(Circle())
                                .scaleEffect(0.5)
                                .frame(maxWidth: 15, alignment: .trailing)
                            
                        }
                        Button{
                            recipe.toggleFavorited()
                        } label: {
                            
                            Image(systemName: "star.fill")
                                .foregroundColor(.white)
                                .padding(10)
                                .background(recipe.isFavorited ? .yellow : .GPTdarkGrey())
                                .clipShape(Circle())
                            
                        }
                        .frame(maxWidth: 10, alignment: .trailing)
                        .padding()
                    }
                }
            }
            .background(Color.GPTlightGrey())
            .cornerRadius(12)
        }

    }
}

struct RecipesCardView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeCardView()
//            .previewLayout(.sizeThatFits)
            .environmentObject(Model().usersRecipes.first!)
    }
}

//
//  RecipesCardView.swift
//  Card
//
//  Created by Andy Chen on 3/10/23.
//

import SwiftUI

struct RecipeCardView: View {
    let recipe:SavedRecipe
    
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
                        
                        Text("Cooking Time : \(recipe.time) minutes")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding([.leading,.bottom])
                            .foregroundColor(.secondary)
                    }
                    
                    Button{
                        
                    } label: {
                        Image(systemName: "bookmark")
                            .foregroundColor(.black)
                            .padding(.vertical, 4)
                            .padding(.horizontal, 6)
                            .overlay {
                                Capsule()
                                    .stroke(lineWidth: 1)
                            }
                    }
                    .frame(maxWidth: 30, alignment: .trailing)
                    .padding()
                }
            }
            .cornerRadius(12)
        }

    }
}

struct RecipesCardView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeCardView(recipe: SavedRecipe.sampleIndividualData)
            .previewLayout(.sizeThatFits)
    }
}

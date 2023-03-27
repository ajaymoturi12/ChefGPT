//
//  RecipesCardView.swift
//  Card
//
//  Created by Andy Chen on 3/10/23.
//

import SwiftUI

struct RecipesCardView: View {
    let recipes = SavedRecipe.sampleIndividualData


    var body: some View {
        ZStack {
            VStack {
                
                AsyncImage(url: URL(string: recipes.foodImage)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 150)
                        .clipped()
                                    
                } placeholder: {
                    Color.gray
                        .frame(height: 150)
                }
                
                Image(recipes.foodImage)
                    
                HStack {
                    
                    VStack {
                        Text(recipes.name)
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding([.leading,.bottom])
                        
                        Text("Cooking Time : \(recipes.time) minutes")
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
        RecipesCardView()
            .previewLayout(.sizeThatFits)
    }
}

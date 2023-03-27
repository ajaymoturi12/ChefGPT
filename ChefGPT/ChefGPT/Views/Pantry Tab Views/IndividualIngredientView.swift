//
//  IndividualIngredientView.swift
//  ChefGPT
//
//  Created by Ethan Fox on 3/27/23.
//

import SwiftUI

struct IndividualIngredientView: View {
    
    @State var ingredient: ExtendedIngredients
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.gray)
                .frame(width: 360, height: 70)
                .cornerRadius(10)
            HStack(spacing: -10) {
                Image(systemName: "leaf.circle")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .padding(25)
                Text(ingredient.name)
                Spacer()
            }
            
            HStack {
                Spacer()
                Button {
                    if ingredient.amount > 0 {
                        ingredient.amount -= 1
                    }
                } label: {
                    Image(systemName: "minus.circle.fill")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.black)
                }
                
                ZStack {
                    Rectangle()
                        .foregroundColor(.white)
                        .frame(width: 50, height: 25)
                    if let unit = ingredient.unit {
                        Text("\(ingredient.amount) \(unit)")
                    } else {
                        Text("\(ingredient.amount)")
                    }
                }
                Button {
                    ingredient.amount += 1
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.black)
                }
            }.padding(30)
        }
    }
}

struct IndividualIngredientView_Previews: PreviewProvider {
    static var previews: some View {
        IndividualIngredientView(ingredient: ExtendedIngredients.exampleData.first!)
    }
}

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
                .foregroundColor(.GPTlightGrey())
            HStack() {
                HStack {
                    Image(systemName: "leaf.circle")
                        .resizable()
                        .frame(width: 50, height: 50)
//                        .padding(25)
                    Text(ingredient.name)
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
                        
                        Text(String(format: "%.1f", ingredient.amount) + " \(ingredient.unit)")
                    }
                    
                    .frame(width:100)
                    .cornerRadius(10)
                    Button {
                        ingredient.amount += 1
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.black)
                    }
                }
            }
            .padding()
            
        }
        .frame(width: .infinity, height: 70)
        .cornerRadius(10)
    }
}

struct IndividualIngredientView_Previews: PreviewProvider {
    static var previews: some View {
        IndividualIngredientView(ingredient: ExtendedIngredients.exampleData.first!)
    }
}

extension Double {
    func truncate(places : Int)-> Double {
        return Double(floor(pow(10.0, Double(places)) * self)/pow(10.0, Double(places)))
    }
}

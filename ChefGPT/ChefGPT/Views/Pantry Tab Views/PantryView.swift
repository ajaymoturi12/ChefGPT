//
//  PantryView.swift
//  ChefGPT
//
//  Created by Ethan Fox on 3/13/23.
//

import SwiftUI

struct PantryView: View {
    @EnvironmentObject var model: Model
    
    var body: some View {
        ZStack {
            VStack {
                Text("The Pantry")
                    .font(.system(.largeTitle, design: .default, weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                ScrollView {
                    VStack {
                        ForEach(model.usersPantry, id:\.name) { ingredient in
                            IndividualIngredientView(ingredient: ingredient)
                                .onLongPressGesture {
                                    model.removeFromPantry(item: ingredient)
                                }
                        }
                        .animation(.linear, value: 0.2)
                    }
                }
            }

        }
        .padding()
    }
}
struct PantryView_Previews: PreviewProvider {
    static var previews: some View {
        PantryView()
            .environmentObject(Model())
    }
}

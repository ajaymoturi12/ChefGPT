//
//  ExploreDetailView.swift
//  ChefGPT
//
//  Created by Ethan Fox on 4/17/23.
//

import SwiftUI

struct ExploreDetailView: View {
    
    @State var recipe: SavedRecipe
    @EnvironmentObject var model:Model
    @Environment(\.managedObjectContext) var moc
    var body: some View {
        ZStack {
            DetailView(recipe: recipe)
            VStack {
                Spacer()
                Button {
                    model.addRecipe(recipe: recipe)
                    model.saveRecipe(recipe: recipe, context: moc)
                } label: {
                    Label("Add to Recipes", systemImage: "fork.knife")
                        .padding([.leading, .trailing], 20)
                        .padding([.top, .bottom], 10)
                              // #0B6F6F
                        .background(Color(red: 11/255, green: 111/255, blue: 111/255))
                        .cornerRadius(15)
                }
                .buttonStyle(.plain)
                .foregroundColor(.white)
            }
        }
    }
}

struct ExploreDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreDetailView(recipe: SavedRecipe.sampleIndividualData)
    }
}

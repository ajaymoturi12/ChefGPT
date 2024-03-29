//
//  HomeView.swift
//  ChefGPT
//
//  Created by Ethan Fox on 3/13/23.
//

import SwiftUI

struct HomeView: View {
    @Environment(\.managedObjectContext) var moc
    @EnvironmentObject var model:Model
    @State var favoritesChosen = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Welcome Home")
                    .font(.system(.largeTitle, design: .default, weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                Picker("Favorites", selection: $favoritesChosen) {
                    Text("Favorites").tag(true)
                    Text("Past Recipes").tag(false)
                }
                .colorMultiply(.GPTorange())
                // The grey of the picker does not match the GPTlightGrey, so I have changed to be a nicer orange
                
                
                .pickerStyle(.segmented)
                .padding([.leading, .trailing])
                
                    
                    
                ScrollView(showsIndicators: false) {
                    VStack {
                        ForEach(model.usersRecipes.filter({ recipe in favoritesChosen ? recipe.isFavorited : true }), id:\.id) { recipe in
                            NavigationLink {
                                DetailView(recipe: recipe)
                            } label: {
                                RecipeCardView()
                                    .environmentObject(recipe)
                            }
                            .accentColor(.black)
                        }
                        
                    }
                }
            }
            .padding()
        }
//        .onAppear {
//            model.load_recipes(context: moc)
//        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(Model())
    }
}

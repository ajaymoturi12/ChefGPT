//
//  HomeView.swift
//  ChefGPT
//
//  Created by Ethan Fox on 3/13/23.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var model:Model
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(model.usersRecipes, id:\.id) { recipe in
                    RecipeCardView(recipe: recipe)
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

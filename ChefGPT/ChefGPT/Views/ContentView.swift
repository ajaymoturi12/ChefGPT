//
//  ContentView.swift
//  ChefGPT
//
//  Created by Ajay Moturi on 3/6/23.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var recipes: FetchedResults<User_Recipe>
    var body: some View {
        MainView()
//        VStack {
//            List(recipes) { recipe in
//                Text(recipe.name ?? "Unknown")
//            }
//        }
//
//        Button("Add") {
//            let recipe = User_Recipe(context: moc)
//            recipe.id = 1234
//            recipe.name = "test recipe 1"
//            try? moc.save()
//        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

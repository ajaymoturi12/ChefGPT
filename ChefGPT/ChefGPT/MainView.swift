//
//  AppView.swift
//  ChefGPT
//
//  Created by Ethan Fox on 3/13/23.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "square")
                }
            PantryView()
                .tabItem {
                    Label("Pantry", systemImage: "square")
                }
            ExploreView()
                .tabItem {
                    Label("Explore", systemImage: "square")
                }
        }
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

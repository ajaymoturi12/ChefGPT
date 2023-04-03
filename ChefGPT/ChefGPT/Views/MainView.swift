//
//  AppView.swift
//  ChefGPT
//
//  Created by Ethan Fox on 3/13/23.
//

import SwiftUI

struct MainView: View {
    
    @StateObject var model = Model()
    
    var body: some View {
        let classifier = ImageClassifier()
        let _ = classifier.test()
        
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
        .environmentObject(model)
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

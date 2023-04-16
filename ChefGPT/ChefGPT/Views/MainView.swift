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
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            ExploreView()
                .tabItem {
                    Label("Explore", systemImage: "shippingbox.fill")
                }
            PantryView()
                .tabItem {
                    Label("Pantry", systemImage: "globe")
                }
            ScanView()
                .tabItem {
                    Label("Scan", systemImage: "camera.metering.none")
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

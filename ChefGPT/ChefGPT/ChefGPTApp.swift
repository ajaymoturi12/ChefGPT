//
//  ChefGPTApp.swift
//  ChefGPT
//
//  Created by Ajay Moturi on 3/6/23.
//

import SwiftUI

@main
struct ChefGPTApp: App {
    @StateObject var model = UserData()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(model)
        }
    }
}

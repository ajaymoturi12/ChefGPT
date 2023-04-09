//
//  ChefGPTApp.swift
//  ChefGPT
//
//  Created by Ajay Moturi on 3/6/23.
//

import SwiftUI

@main
struct ChefGPTApp: App {
    @StateObject private var dataController = DataController()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}

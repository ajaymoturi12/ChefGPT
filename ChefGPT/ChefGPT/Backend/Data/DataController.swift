//
//  DataController.swift
//  ChefGPT
//
//  Created by Ajay Moturi on 4/9/23.
//
import Foundation
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "RecipeModel")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
}

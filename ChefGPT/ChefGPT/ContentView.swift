//
//  ContentView.swift
//  ChefGPT
//
//  Created by Ajay Moturi on 3/6/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        let req = SpoonacularReq()
        let _ = req.get_recipes(ingredient_list: "chocolate cake")
        MainView()
    }
    
    func call() {
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//  SpoonacularReq.swift
//  ChefGPT
//
//  Created by Ajay Moturi on 3/13/23.
//

import Foundation
import SwiftUI

class SpoonacularReq: ObservableObject {
    @Published var results: Results
//    @Published var curRecipe: Recipe
    
    init() {
        self.results = Results(results: [], offset: 0, number: 0, totalResults: 0)
    }
    
    func get_recipes(ingredient_list: String, cuisine: String = "", equipment: String = "", num_recipes: Int = 5) {
        let str = "https://api.spoonacular.com/recipes/complexSearch?query=\(ingredient_list)&number=\(num_recipes)&cuisine=\(cuisine)&equipment=\(equipment)&apiKey=801ec94c3851432f8f57ecfa49c0ad25"
        let url = URL(string: str.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)!
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Request error: ", error)
                return
            }
            
            guard let response = response as? HTTPURLResponse else { return }
            
            if response.statusCode == 200 {
                guard let data = data else { return }
                DispatchQueue.main.async {
                    do {
                        let decodedData = try JSONDecoder().decode(Results.self, from: data)
                        self.results = decodedData
                        print(self.results)
                    } catch let error {
                        print("Error decoding: ", error)
                    }
                }
            }
        }
        
        dataTask.resume()
    }
    
//    func get_recipe_info(id: Int) {
//        let str = "https://api.spoonacular.com/recipes/\(id)/information?includeNutrition=false&apiKey=801ec94c3851432f8f57ecfa49c0ad25"
//        let url = URL(string: str.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)!
//
//        var request = URLRequest(url: url)
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.httpMethod = "GET"
//
//        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
//            if let error = error {
//                print("Request error: ", error)
//                return
//            }
//
//            guard let response = response as? HTTPURLResponse else { return }
//
//            if response.statusCode == 200 {
//                guard let data = data else { return }
//                DispatchQueue.main.async {
//                    do {
//                        let decodedData = try JSONDecoder().decode(Results.self, from: data)
//                        self.results = decodedData
//                        print(self.results)
//                    } catch let error {
//                        print("Error decoding: ", error)
//                    }
//                }
//            }
//        }
//    }
}

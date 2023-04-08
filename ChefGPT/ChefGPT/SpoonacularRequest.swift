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
    @Published var curRecipe: Recipe
    
    init() {
        self.results = Results(results: [], offset: 0, number: 0, totalResults: 0)
        self.curRecipe = Recipe(vegetarian: false, vegan: false, glutenFree: false, dairyFree: false, preparationMinutes: -1, cookingMinutes: -1, analyzedInstructions: [], extendedIngredients: [])
    }
    
    func get_recipes_from_ingredients(ingredient_list: [String] = [], num_recipes: Int = 5) {
        let str = "https://api.spoonacular.com/recipes/findByIngredients?ingredients=\(ingredient_list.joined(separator: ",+"))&number=\(num_recipes)&cuisine=\(cuisine)&equipment=\(equipment)&apiKey=801ec94c3851432f8f57ecfa49c0ad25"
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
//                        print(self.results)
                    } catch let error {
                        print("Error decoding: ", error)
                    }
                }
            }
        }
        
        dataTask.resume()
    }
    
    func get_recipe_from_filters(cuisine: String = "", equipment: String = "", diet: [String] = [], intolerances: [String], max_ready_time: Int, num_recipes: Int = 5) {
        let str = "https://api.spoonacular.com/recipes/complexSearch?intolerances=\(intolerances.joined(separator: ","))&max_ready_time=\(max_ready_time)&diet=\(diet.joined(separator:","))&number=\(num_recipes)&cuisine=\(cuisine)&equipment=\(equipment)&apiKey=801ec94c3851432f8f57ecfa49c0ad25"
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
//                        print(self.results)
                    } catch let error {
                        print("Error decoding: ", error)
                    }
                }
            }
        }
        
        dataTask.resume()
    }
    
    func get_recipe_info(id: Int) {
        let str = "https://api.spoonacular.com/recipes/\(id)/information?includeNutrition=false&apiKey=801ec94c3851432f8f57ecfa49c0ad25"
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
                        let decodedData = try JSONDecoder().decode(Recipe.self, from: data)
                        self.curRecipe = decodedData
//                        print(self.curRecipe)
                    } catch let error {
                        print("Error decoding: ", error)
                    }
                }
            }
        }
        dataTask.resume()
    }
}

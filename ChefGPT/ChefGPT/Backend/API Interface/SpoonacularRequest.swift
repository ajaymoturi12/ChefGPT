//
//  SpoonacularReq.swift
//  ChefGPT
//
//  Created by Ajay Moturi on 3/13/23.
//

import Foundation
import SwiftUI

class SpoonacularReq: ObservableObject {
    let apiKey = "801ec94c3851432f8f57ecfa49c0ad25"
    @Published var results: Results
    @Published var curRecipe: Recipe
    
    init() {
        self.results = Results(results: [], offset: 0, number: 0, totalResults: 0)
        self.curRecipe = Recipe(vegetarian: false, vegan: false, glutenFree: false, dairyFree: false, preparationMinutes: -1, cookingMinutes: -1, analyzedInstructions: [], extendedIngredients: [])
    }
    
    private func get_recipes_from_ingredients(ingredient_list: [String] = [], num_recipes: Int = 5) {
            let str = "https://api.spoonacular.com/recipes/findByIngredients?ingredients=\(ingredient_list.joined(separator: ",+"))&number=\(num_recipes)&apiKey=\(apiKey)"
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
        
    private func get_recipe_from_filters(cuisine: String = "", equipment: String = "", diet: [String] = [], intolerances: [String], max_ready_time: Int, num_recipes: Int = 5) {
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
    
    private func get_recipe_info(id: Int) {
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
    
    
    // This is a combination of the two methods above shoved together, and clean up with some async await 🤓👌
    func getRecipesGivenIngredients(ingredients: [String], count: Int) async throws -> [SavedRecipe] {
        
        var recipes = [SavedRecipe]()
        
        let string = "https://api.spoonacular.com/recipes/findByIngredients?ingredients=\(ingredients.joined(separator: ",+"))&number=\(count)&apiKey=\(apiKey)"
        
        let url = URL(string: string.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)!
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error while fetching data") }
        
        let decodedData = try JSONDecoder().decode(Results.self, from: data)
        for recipe in decodedData.results {
            let id = recipe.id
            
            let secondString = "https://api.spoonacular.com/recipes/\(id)/information?includeNutrition=false&apiKey=\(apiKey)"
            
            let secondUrl = URL(string: secondString)!
            
            var secondRequst = URLRequest(url: secondUrl)
            secondRequst.setValue("application/json", forHTTPHeaderField: "Content-Type")
            secondRequst.httpMethod = "GET"
            
            
            let (data, response) = try await URLSession.shared.data(for: secondRequst)
            
            guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error while fetching data") }
            let secondDecodedData = try JSONDecoder().decode(Recipe.self, from: data)
            
            var ingredients = [Encodable_Extended_Ingredients]()
            var instructions = [Encodable_Instructions]()
            for ing in secondDecodedData.extendedIngredients {
                ingredients.append(Encodable_Extended_Ingredients(name:ing.name,amount: ing.amount,unit:ing.unit ))
            }
            for inst in secondDecodedData.analyzedInstructions {
                var steps = [Encodable_Steps]()
                for step in inst.steps {
                    steps.append(Encodable_Steps(number: step.number, step: step.step))
                }
                instructions.append(Encodable_Instructions(name: inst.name, steps: steps))
            }
            
            let fullRecipe = SavedRecipe(id: id, name: recipe.title, foodImage: recipe.image, isFavorited: false, vegetarian: secondDecodedData.vegetarian, vegan: secondDecodedData.vegan, glutenFree: secondDecodedData.glutenFree, dairyFree: secondDecodedData.dairyFree, preparationMinutes: secondDecodedData.preparationMinutes, cookingMinutes: secondDecodedData.cookingMinutes, ingredients: ingredients, instructions: instructions)
            
            recipes.append(fullRecipe)
        }
        return recipes
    }
    
    func getRecipesGivenFilters(cuisine: String = "", equipment: String = "", diet: [String] = [], intolerances: [String], max_ready_time: Int, num_recipes: Int = 5) async throws -> [SavedRecipe] {
        
        var recipes = [SavedRecipe]()
        
        let string = "https://api.spoonacular.com/recipes/complexSearch?intolerances=\(intolerances.joined(separator: ","))&max_ready_time=\(max_ready_time)&diet=\(diet.joined(separator:","))&number=\(num_recipes)&cuisine=\(cuisine)&equipment=\(equipment)&apiKey=\(apiKey)"
        
        let url = URL(string: string.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)!
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error while fetching data") }
        
        let decodedData = try JSONDecoder().decode(Results.self, from: data)
        for recipe in decodedData.results {
            let id = recipe.id
            
            let secondString = "https://api.spoonacular.com/recipes/\(id)/information?includeNutrition=false&apiKey=\(apiKey)"
            
            let secondUrl = URL(string: secondString)!
            
            var secondRequst = URLRequest(url: secondUrl)
            secondRequst.setValue("application/json", forHTTPHeaderField: "Content-Type")
            secondRequst.httpMethod = "GET"
            
            
            let (data, response) = try await URLSession.shared.data(for: secondRequst)
            
            guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error while fetching data") }
            let secondDecodedData = try JSONDecoder().decode(Recipe.self, from: data)
            
            var ingredients = [Encodable_Extended_Ingredients]()
            var instructions = [Encodable_Instructions]()
            for ing in secondDecodedData.extendedIngredients {
                ingredients.append(Encodable_Extended_Ingredients(name:ing.name,amount: ing.amount,unit:ing.unit ))
            }
            for inst in secondDecodedData.analyzedInstructions {
                var steps = [Encodable_Steps]()
                for step in inst.steps {
                    steps.append(Encodable_Steps(number: step.number, step: step.step))
                }
                instructions.append(Encodable_Instructions(name: inst.name, steps: steps))
            }
            
            let fullRecipe = SavedRecipe(id: id, name: recipe.title, foodImage: recipe.image, isFavorited: false, vegetarian: secondDecodedData.vegetarian, vegan: secondDecodedData.vegan, glutenFree: secondDecodedData.glutenFree, dairyFree: secondDecodedData.dairyFree, preparationMinutes: secondDecodedData.preparationMinutes, cookingMinutes: secondDecodedData.cookingMinutes, ingredients: ingredients, instructions: instructions)
            
            recipes.append(fullRecipe)
        }
        return recipes
    }

}

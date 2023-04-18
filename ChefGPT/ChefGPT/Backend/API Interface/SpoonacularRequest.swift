//
//  SpoonacularReq.swift
//  ChefGPT
//
//  Created by Ajay Moturi on 3/13/23.
//

import Foundation
import SwiftUI

let apiKey1 = "3f9f762b05e64407bede87d57f4899ef"
let apiKey =  "3f9f762b05e64407bede87d57f4899ef"
class SpoonacularReq: ObservableObject {
    @Published var results: Results
    @Published var curRecipe: Recipe
    
    init() {
        self.results = Results(results: [], offset: 0, number: 0, totalResults: 0)
        self.curRecipe = Recipe(vegetarian: false, vegan: false, glutenFree: false, dairyFree: false, preparationMinutes: -1, cookingMinutes: -1, analyzedInstructions: [], extendedIngredients: [])
    }
    
    private static func get_recipes_from_ingredients(ingredient_list: [String] = [], num_recipes: Int = 5) -> [SavedRecipe] {
            let str = "https://api.spoonacular.com/recipes/findByIngredients?ingredients=\(ingredient_list.joined(separator: ",+"))&number=\(num_recipes)&apiKey=\(apiKey)"
            let url = URL(string: str.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)!
            var recipes = [SavedRecipe]()
            
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
                            let decodedData = try JSONDecoder().decode([RecipeInfo].self, from: data)
                            for recipe in decodedData {
                                let info = get_recipe_info(id: recipe.id)!
                                var ingredients = [Encodable_Extended_Ingredients]()
                                var instructions = [Encodable_Instructions]()
                                for ing in info.extendedIngredients {
                                    ingredients.append(Encodable_Extended_Ingredients(name:ing.name,amount: ing.amount,unit:ing.unit ))
                                }
                                for inst in info.analyzedInstructions {
                                    var steps = [Encodable_Steps]()
                                    for step in inst.steps {
                                        steps.append(Encodable_Steps(number: step.number, step: step.step))
                                    }
                                    instructions.append(Encodable_Instructions(name: inst.name, steps: steps))
                                }

                                let fullRecipe = SavedRecipe(id: recipe.id, name: recipe.title, foodImage: recipe.image, isFavorited: false, vegetarian: info.vegetarian, vegan: info.vegan, glutenFree: info.glutenFree, dairyFree: info.dairyFree, preparationMinutes: info.preparationMinutes, cookingMinutes: info.cookingMinutes, ingredients: ingredients, instructions: instructions)

                                recipes.append(fullRecipe)
                            }
                        } catch let error {
                            print("Error decoding: ", error)
                        }
                    }
                }
            }
            
            dataTask.resume()
            return recipes
        }
        
    private static func get_recipe_from_filters(cuisine: String = "", equipment: String = "", diet: [String] = [], intolerances: [String], max_ready_time: Int, num_recipes: Int = 5) {
        let str = "https://api.spoonacular.com/recipes/complexSearch?intolerances=\(intolerances.joined(separator: ","))&max_ready_time=\(max_ready_time)&diet=\(diet.joined(separator:","))&number=\(num_recipes)&cuisine=\(cuisine)&equipment=\(equipment)&apiKey=\(apiKey)"
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
//                        self.results = decodedData
//                        print(self.results)
                    } catch let error {
                        print("Error decoding: ", error)
                    }
                }
            }
        }
        
        dataTask.resume()
    }
    
    private static func get_recipe_info(id: Int) -> Recipe? {
        let str = "https://api.spoonacular.com/recipes/\(id)/information?includeNutrition=false&apiKey=\(apiKey)"
        let url = URL(string: str.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)!
        var ret : Recipe?
        
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
                guard let data = data else {
                    return }
                DispatchQueue.main.async {
                    do {
                        let decodedData = try JSONDecoder().decode(Recipe.self, from: data)
                        ret = decodedData
                    } catch let error {
                        print("Error decoding: ", error)
                        return
                    }
                }
            }
        }
        dataTask.resume()
        return ret
    }
    
    
    // This is a combination of the two methods above shoved together, and clean up with some async await 🤓👌
    static func getRecipesGivenIngredients(ingredients: [String], count: Int) async throws -> [SavedRecipe] {
        
        var recipes = [SavedRecipe]()
        
        let string = "https://api.spoonacular.com/recipes/findByIngredients?ingredients=\(ingredients.joined(separator: ",+"))&number=\(count)&apiKey=\(apiKey)"
        
        let url = URL(string: string.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)!
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error while fetching data") }
        
        let decodedData = try JSONDecoder().decode([RecipeInfo].self, from: data)
        for recipe in decodedData {
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
    
    static func getRecipesGivenFilters(cuisine: String = "", equipment: String = "", diet: [String] = [], intolerances: [String], max_ready_time: Int, num_recipes: Int = 5) async throws -> [SavedRecipe] {
        
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

//
//  ExploreView.swift
//  ChefGPT
//
//  Created by Ethan Fox on 3/13/23.
//

import SwiftUI

enum Source: String {
    case Pantry, Filters
}

struct ExploreView: View {
    @EnvironmentObject var model: Model
    
    @State var showingfilterBar = false
    @State var cuisine: cuisine = .Chinese
    @State var time: time = .Five
    @State var dietary: dietary = .DairyFree
    
    @State var selectedSource: Source = .Pantry;
    @State var pantryRecipes: [SavedRecipe] = []
    @State var filterRecipes: [SavedRecipe] = []
    
    var body: some View {
          VStack {
              Text("Welcome Home")
                  .font(.system(.largeTitle, design: .default, weight: .bold))
                  .frame(maxWidth: .infinity, alignment: .leading)
              Button {
                  showingfilterBar = true
              } label: {
                  Label("Filter", systemImage: "line.3.horizontal")
                      .padding([.leading, .trailing], 20)
                      .padding([.top, .bottom], 10)
                            // #0B6F6F
                      .background(Color(red: 11/255, green: 111/255, blue: 111/255))
                      .cornerRadius(15)
              }
              .buttonStyle(.plain)
              .foregroundColor(.white)
              
              Divider()
                  .padding(.horizontal)
              
              Picker("Source", selection: $selectedSource) {
                  Text("Pantry").tag(Source.Pantry)
                  Text("Filters").tag(Source.Filters)
                  
              }
              .pickerStyle(.segmented).colorMultiply(.GPTorange())
              .onAppear(){
                  Task {
                      do {
                          try await pantryRecipes = SpoonacularReq.getRecipesGivenIngredients(ingredients: model.getUserIngredients(), count: 10)
                      } catch {
                          print(error)
                      }

                  }
              }

              ScrollView(showsIndicators: false) {
                  VStack {
                      ForEach(selectedSource == .Pantry ? pantryRecipes : filterRecipes, id:\.id) { recipe in
                          NavigationLink {
                              DetailView()
                          } label: {
                              RecipeCardView()
                                  .environmentObject(recipe)
                          }
                          .accentColor(.black)
                      }
                  }
              }
          }
          .padding()
          .sheet(isPresented: $showingfilterBar) {
              ExploreFilterView(show: $showingfilterBar, selectedCuisine: $cuisine, selectedDietary: $dietary, selectedTime: $time)
                  .presentationDetents([.large, .medium, .fraction(0.35)])
                  .onChange(of:cuisine) { newValue in
                      Task {
                          do {
                              try await filterRecipes = SpoonacularReq.getRecipesGivenFilters(cuisine: cuisine.rawValue, equipment: "", diet: [dietary.rawValue], intolerances: [], max_ready_time: time.rawValue, num_recipes: 10)
                          } catch {
                              print(error)
                          }
                      }
                  }
                  .onChange(of:dietary) { newValue in
                      Task {
                          do {
                              try await filterRecipes = SpoonacularReq.getRecipesGivenFilters(cuisine: cuisine.rawValue, equipment: "", diet: [dietary.rawValue], intolerances: [], max_ready_time: time.rawValue, num_recipes: 10)
                          } catch {
                              print(error)
                          }
                      }
                  }

                  .onChange(of:time) { newValue in
                      Task {
                          do {
                              try await filterRecipes = SpoonacularReq.getRecipesGivenFilters(cuisine: cuisine.rawValue, equipment: "", diet: [dietary.rawValue], intolerances: [], max_ready_time: time.rawValue, num_recipes: 10)
                          } catch {
                              print(error)
                          }
                      }
                  }
          }
      }
      
  }

//struct ExploreView_Previews: PreviewProvider {
//    static var previews: some View {
//        ExploreView(cuisine: <#Binding<cuisine>#>, time: <#Binding<time>#>, dietary: <#Binding<dietary>#>)
//    }
//}

//
//  ExploreFilterView.swift
//  ChefGPT
//
//  Created by Andy Chen on 4/10/23.
//

import SwiftUI

enum time: Int {
    case Five = 5
    case Ten = 10
    case Thirty = 30
    case Hour = 60
}
enum cuisine {
    case Chinese, Mexican, Indian, Italian;
}
enum dietary {
    case Vegan, Vegetarian, GlutenFree, DairyFree;
}


struct ExploreFilterView: View {
    @State private var showSheet: Bool =  false;
    @State private var selectedCuisine: cuisine = .Chinese
    @State private var selectedDietary: dietary = .Vegan;
    @State private var selectedTime: time = .Five;

    var body: some View {
        
        VStack {
            Text("Cuisine Type: ")
            Picker("Cuisine", selection: $selectedCuisine) {
                Text("Chinese").tag(cuisine.Chinese)
                Text("Mexican").tag(cuisine.Mexican)
                Text("Indian").tag(cuisine.Indian)
                Text("Italian").tag(cuisine.Italian)
            }.pickerStyle(.segmented).colorMultiply(.GPTorange())
            
            Text("Dietary Restrictions: ")
            Picker("Dietary", selection: $selectedDietary) {
                    Text("Vegan").tag(dietary.Vegan)
                Text("Vegetarian").tag(dietary.Vegetarian)
                Text("GlutenFree").tag(dietary.GlutenFree)
                Text("DairyFree").tag(dietary.DairyFree)
            }.pickerStyle(.segmented).colorMultiply(.GPTorange())
            
            Text("Time: ")
            Picker("Time", selection: $selectedTime) {
                Text("5 min").tag(time.Five)
                Text("10 min").tag(time.Ten)
                Text("30 min").tag(time.Thirty)
                Text("1+ Hour").tag(time.Hour)
            }.pickerStyle(.segmented).colorMultiply(.GPTorange())
        }
    }
}


struct ExploreFilterView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreFilterView()
    }
}
















//        Button("Filter") {
//            showSheet.toggle();
//        }
//        .sheet(isPresented: $showSheet) {
//            HStack() {
//                //Cuisine Filter
//                VStack {
////                    Text("Cuisine Type: ");
////                    Toggle(isOn: $isSelected) {
////                        Label(isSelected ? "Chinese" : "Chinese",
////                              systemImage: "Chinese")
////                        .symbolVariant(isSelected ? .fill : .none)
////                        Label(isSelected ? "Mexican": "Mexican",
////                              systemImage: "Mexican")
////                        .symbolVariant(isSelected ? .fill : .none)
////                    }.toggleStyle(.button)
////
////                    Toggle(isOn: $isSelected) {
////
////                    }.toggleStyle(.button)
////
////                    Toggle(isOn: $isSelected) {
////                        Label(isSelected ? "Indian": "Indian",
////                              systemImage: "Indian")
////                        .symbolVariant(isSelected ? .fill : .none)
////                    }.toggleStyle(.button)
////
////                    Toggle(isOn: $isSelected) {
////                        Label(isSelected ? "Italian": "Italian",
////                              systemImage: "Italian")
////                        .symbolVariant(isSelected ? .fill : .none)
////                    }.toggleStyle(.button)
//
//                }
//                //Dietary Filter
//                VStack {
//                    Text("Dietary: ");
//                    Toggle(isOn: $isSelected) {
//                        Label(isSelected ? "Vegan" : "Vegan",
//                              systemImage: "Vegan")
//                        .symbolVariant(isSelected ? .fill : .none)
//                    }.toggleStyle(.button)
//
//                    Toggle(isOn: $isSelected) {
//                        Label(isSelected ? "Vegetarian": "Vegetarian",
//                              systemImage: "Vegetarian")
//                        .symbolVariant(isSelected ? .fill : .none)
//                    }.toggleStyle(.button)
//
//                    Toggle(isOn: $isSelected) {
//                        Label(isSelected ? "GlutenFree": "GlutenFree",
//                              systemImage: "GlutenFree")
//                        .symbolVariant(isSelected ? .fill : .none)
//                    }.toggleStyle(.button)
//
//                    Toggle(isOn: $isSelected) {
//                        Label(isSelected ? "DairyFree": "DairyFree",
//                              systemImage: "DairyFree")
//                        .symbolVariant(isSelected ? .fill : .none)
//                    }.toggleStyle(.button)
//                }
//                //Time Filter
//                VStack {
//                    Text("Dietary: ");
//                    Toggle(isOn: $isSelected) {
//                        Label(isSelected ? "5 mins" : "5 mins",
//                              systemImage: "5 mins")
//                        .symbolVariant(isSelected ? .fill : .none)
//                    }.toggleStyle(.button)
//
//                    Toggle(isOn: $isSelected) {
//                        Label(isSelected ? "10 mins": "10 mins",
//                              systemImage: "10 mins")
//                        .symbolVariant(isSelected ? .fill : .none)
//                    }.toggleStyle(.button)
//
//                    Toggle(isOn: $isSelected) {
//                        Label(isSelected ? "30 mins": "30 mins",
//                              systemImage: "30 mins")
//                        .symbolVariant(isSelected ? .fill : .none)
//                    }.toggleStyle(.button)
//
//                    Toggle(isOn: $isSelected) {
//                        Label(isSelected ? "1+ hour": "1+ hour",
//                              systemImage: "1+ hour")
//                        .symbolVariant(isSelected ? .fill : .none)
//                    }.toggleStyle(.button)
//                }
//            }
//
//        }

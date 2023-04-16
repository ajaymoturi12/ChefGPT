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
enum cuisine : String {
    case None = ""
    case Chinese
    case Mexican
    case Indian
    case Italian
    case American
}
enum dietary: String {
    case None = "", Vegan, Vegetarian, GlutenFree, DairyFree
}


struct ExploreFilterView: View {
    @Binding var show: Bool
    @Binding var selectedCuisine: cuisine
    @Binding var selectedDietary: dietary
    @Binding var selectedTime: time

    var body: some View {
        
        VStack {
            Text("Cuisine Type: ")
            Picker("Cuisine", selection: $selectedCuisine) {
                Text("Any").tag(cuisine.None)
                Text("Chinese").tag(cuisine.Chinese)
                Text("Mexican").tag(cuisine.Mexican)
                Text("Indian").tag(cuisine.Indian)
                Text("Italian").tag(cuisine.Italian)
                Text("American").tag(cuisine.American)
            }.pickerStyle(.segmented).colorMultiply(.GPTorange())
            
            Text("Dietary Restrictions: ")
            Picker("Dietary", selection: $selectedDietary) {
                Text("None").tag(dietary.None)
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


//struct ExploreFilterView_Previews: PreviewProvider {
//    static var previews: some View {
//        ExploreFilterView()
//    }
//}

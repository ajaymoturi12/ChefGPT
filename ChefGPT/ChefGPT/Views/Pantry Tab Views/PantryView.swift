//
//  PantryView.swift
//  ChefGPT
//
//  Created by Ethan Fox on 3/13/23.
//

import SwiftUI

struct PantryView: View {
    @EnvironmentObject var model: Model
    
    @State private var showingImagePicker = false
    @State private var inputImages:[UIImage] = [UIImage]()
    
    var body: some View {
        ZStack {
            VStack {
                Text("The Pantry")
                    .font(.system(.largeTitle, design: .default, weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                ScrollView {
                    VStack {
                        ForEach(model.usersPantry, id:\.name) { ingredient in
                            IndividualIngredientView(ingredient: ingredient)
                        }
                    }
                }
            }

            //Button stuff overlay
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    // This is the button that someone presses to add new ingredients 
                    Button {
                        showingImagePicker = true
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 70, height: 70)
                            .foregroundColor(.GPTorange())
                    }
                }
            }
        }
        .padding()
        .fullScreenCover(isPresented: $showingImagePicker) {
            CameraView()
        }
    }
}
struct PantryView_Previews: PreviewProvider {
    static var previews: some View {
        PantryView()
            .environmentObject(Model())
    }
}

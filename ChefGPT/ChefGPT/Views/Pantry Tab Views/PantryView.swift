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
            // Content should be here
            
            
            VStack(spacing: -20) {
                Text("Welcome to your \n Pantry")
                    .font(.system(size: 35))
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.vertical, 20)
                ZStack{
                    Rectangle()
                        .foregroundColor(.gray)
                        .frame(width: 360, height: 35)
                    HStack {
                        Text("Unsorted")
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                    }
                    
                }.padding()
                
                ScrollView {
                    VStack {
                        ForEach(model.usersPantry, id:\.name) { ingredient in
                            Text("hey")
                        }
                    }
                }
                
                Text("Out of Stock")
                    .font(.system(size:30))
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.vertical, 40)
                Spacer()
                HStack {
                    Button {
                        model.usersPantry.append(ExtendedIngredients(name: "New Item", amount: 0, unit: "oz"))
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 70, height: 70)
                            .foregroundColor(.gray)
                            .padding()
                    }
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding()
                Spacer()
                
                
                
                
                // Button on top part
//                VStack {
//                    Spacer()
//                    HStack {
//                        Spacer()
//                        Circle()
//                            .frame(width: 75)
//                            .foregroundColor(.blue)
//                            .onTapGesture {
//                                showingImagePicker = true
//                            }
//                    }
//                }
//                .padding()
            }
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(images: $inputImages)
            }
        }
    }
}
struct PantryView_Previews: PreviewProvider {
    static var previews: some View {
        PantryView()
    }
}

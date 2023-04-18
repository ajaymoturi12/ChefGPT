//
//  BottomSheetView.swift
//
//  Created by Jalen.
//

import SwiftUI

struct BottomSheetView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var model: Model
    let image: UIImage
    
    let quantities = ["cups", "each", "lbs"]
    @State var chosenQuantity = ""
    
    @State var classification: [String]
    @State var amount = 0
    @State var checked = false
    
    var body: some View {
        VStack {
            HStack {
                Button("Go Back") {
                    dismiss()
                }
                .padding()
                .buttonStyle(.borderedProminent)
                .tint(Color(red:96/255, green:96/255, blue:96/255)).foregroundColor(.white)
                Spacer()
            }
            Text("Here's what we see").bold().font(.system(size: 35)).padding(.bottom, 10)
            
            HStack {

                TextField("", text: $classification.first!)
                    .font(.system(.title, design: .rounded))
                    .foregroundColor(Color(.white))
                Spacer()
                
                HStack(spacing: 5) {
                    Button{
                        if amount > 1 {
                            amount -= 1
                        }
                    } label: {
                        Image(systemName: "minus.circle.fill")
                    }
                    .foregroundColor(.white)
                    HStack {
                        Text("\(amount)")
                        Picker("Flavor", selection: $chosenQuantity) {
                            ForEach(quantities, id:\.self) { quantity in
                                Text(quantity)
                            }
                        }
                    }
                    .padding([.leading], 15)
                    .background(.white)
                    .cornerRadius(10)
                    
                    Button {
                        if amount <= 99 {
                            amount += 1
                        }
                    } label: {
                        Image(systemName: "plus.circle.fill")
                        
                    }
                    .foregroundColor(.white)
                }
                
                
                
            }
            .padding([.top, .bottom], 30)
            .padding([.leading, .trailing], 15)
            .background(Color(red:96/255, green:96/255, blue:96/255))
            .cornerRadius(15)
            HStack {
                Button("Nope, Rescan") {
                    dismiss()
                }.buttonStyle(.borderedProminent)
                    .tint(Color(.systemGray3)).foregroundColor(.black)
                    .controlSize(.large)
                Spacer()
                Button("Add To Pantry") {
                    if classification.first! != "" {
                        let ingredient = ExtendedIngredients(name: classification.first!, amount: Double(amount), unit: "each")
                        
                        model.addToPantry(item: ingredient)
                        
                        dismiss()
                    }
                }.buttonStyle(.borderedProminent)
                    .tint(Color(red:237/255,green:104/255, blue:46/255)).foregroundColor(.white)
                    .controlSize(.large)
            }
            Text("Or, it may be")
                .bold()
                .font(.system(size: 30))
                .frame(alignment: .leading)
                .padding([.trailing], 160)
            ZStack {
                Rectangle().foregroundColor(Color(red:96/255, green:96/255, blue:96/255))
                VStack {
                    ForEach(Array(classification[1...3].enumerated()), id:\.1) { index, element in
                        //                        Text("\(index): \(element)")
                        TabBarItem(name: element)
                            .onTapGesture {
                                classification.swapAt(0, index+1)
                            }
                    }
                }
            }
            .frame(width:350, height: 220)
            .cornerRadius(15)
            Spacer()
        }
        .padding([.leading, .trailing])
        .font(.system(.body, design: .rounded))
        .animation(.default, value: 0.5)
    }
}

struct BottomSheetView_Previews: PreviewProvider {
    static var previews: some View {
        BottomSheetView(image: UIImage(named: "banana")!, classification: ["Banana", "Apple", "Strawberry", "Lemon"])
    }
}

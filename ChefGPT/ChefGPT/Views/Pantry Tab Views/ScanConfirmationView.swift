//
//  ConfirmationView.swift
//  ChefGPT
//
//  Created by Jalen Wright on 4/10/23.
//

import SwiftUI


struct ScanConfirmationView: View {
    @State var items:[String] = []
    @State var currentText =  ""
    @State var showingBottomSheet = false;
    
    var body: some View {
        VStack {
            Button("Select Photo!") {
                showingBottomSheet.toggle()
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .sheet(isPresented: $showingBottomSheet) {
            BottomSheetView(displayImmage: Image("apple"))
                .presentationDetents([.large,.large])
        }

    }
}

class ingredients: ObservableObject {
    var name: String
    var amount: Int
    init(name:String, amount:Int) {
        self.name = name
        self.amount = amount
    }
}


struct BottomSheetView: View {
    @Environment(\.dismiss) var dismiss
    @State var displayImmage:Image
    @State var showHomeScreen = false
    @State var ingredientList = ["Tomotao", "Orange", "Bell Pepper"]
    @State var amount = 0
    @State var checked = false
    var body: some View {
        VStack {
            Button("Go Back") {
                dismiss()
            }.buttonStyle(.borderedProminent)
                .tint(Color(red:96/255, green:96/255, blue:96/255)).foregroundColor(.white)
                .frame(height:90, alignment: .topLeading)
                .padding([.trailing], 250)
            Text("Here's what we see").bold().font(.system(size: 35)).padding(.bottom, 10)
            ZStack {
                Rectangle()
                    .foregroundColor(Color(red:96/255, green:96/255, blue:96/255))
                HStack {
                    ZStack{
                        CheckBoxView(checked: $checked, itemChecked: "Apple")
                    }.frame(width:50, height: 25)
                    Text("Apples").foregroundColor(Color(.white))
                    Spacer()
                    Button{amount -= 1} label: {Label("",systemImage: "circle.fill")}
                        .tint(Color(red:70/255, green:56/255, blue:56/255))
                    ZStack{
                        Rectangle().frame(width:40).foregroundColor(.white)
                        Text("\(amount)")
                    }.frame(width:25, height: 25)
                    Button{amount += 1} label: {Label("",systemImage: "circle.fill")}
                        .tint(Color(red:70/255, green:56/255, blue:56/255))
                }.padding()
            }.frame(width:350, height:75) .cornerRadius(15).padding()
            HStack{
                Button("Nope, Rescan"){
                    dismiss()
                }.buttonStyle(.borderedProminent)
                    .tint(Color(.systemGray3)).foregroundColor(.black)
                    .controlSize(.large)
                Spacer()
                Button("Add To Pantry"){
                    
                }.buttonStyle(.borderedProminent)
                    .tint(Color(red:237/255,green:104/255, blue:46/255)).foregroundColor(.white)
                    .controlSize(.large)
            }.padding()
            Text("Or, it may be").bold().font(.system(size: 30)).frame(alignment: .leading).padding([.trailing], 160)
            ZStack {
                Rectangle().foregroundColor(Color(red:96/255, green:96/255, blue:96/255))
                VStack {
                    ForEach(ingredientList,id: \.self) {ingredient in
                        TabBarItem(checked: checked, name: ingredient)
                    }
                }
            }.frame(width:350, height: 220).cornerRadius(15)
            
        }.sheet(isPresented: $showHomeScreen) {
            ContentView()
                .presentationDetents([.medium,.large])
        }
    }
}

struct ScanConfirmationViewPreview: PreviewProvider {
    static var previews: some View {
        ScanConfirmationView()
    }
}

struct CheckBoxView: View {
    @Binding var checked: Bool
    @State var itemChecked: String

    var body: some View {
        Image(systemName: checked ? "square.fill" : "square.fill")
            .resizable()
            .foregroundColor(checked ? Color(UIColor.systemBlue) : Color.white)
            .onTapGesture {
                self.checked.toggle()
            }
            .frame(width: 40, height: 40)
    }
}

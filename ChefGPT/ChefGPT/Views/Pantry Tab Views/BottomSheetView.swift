import SwiftUI



struct BottomSheetView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var model: Model
    let image: UIImage
    
    
    let classification: [String]
    @State var ingredientList = ["Tomotao", "Orange", "Bell Pepper"]
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
            ZStack {
                Rectangle()
                    .foregroundColor(Color(red:96/255, green:96/255, blue:96/255))
                HStack {
                    ZStack{
                        CheckBoxView(checked: $checked, itemChecked: classification.first!)
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
                    
                    let ingredient = ExtendedIngredients(name: classification.first!, amount: Double(amount), unit: "each")
                    
                    model.addToPantry(item: ingredient)
                    
                    
                    dismiss()
                }.buttonStyle(.borderedProminent)
                    .tint(Color(red:237/255,green:104/255, blue:46/255)).foregroundColor(.white)
                    .controlSize(.large)
            }.padding()
            Text("Or, it may be").bold().font(.system(size: 30)).frame(alignment: .leading).padding([.trailing], 160)
            ZStack {
                Rectangle().foregroundColor(Color(red:96/255, green:96/255, blue:96/255))
                VStack {
                    ForEach(classification[1...], id:\.self) {bruh in
                        TabBarItem(checked: checked, name: bruh)
                    }
                }
            }.frame(width:350, height: 220).cornerRadius(15)
            
        }
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


struct BottomSheetView_Previews: PreviewProvider {
    static var previews: some View {
        BottomSheetView(image: UIImage(named: "banana")!, classification: ImageClassifier.classify(image: UIImage(named: "banana")!))
    }
}

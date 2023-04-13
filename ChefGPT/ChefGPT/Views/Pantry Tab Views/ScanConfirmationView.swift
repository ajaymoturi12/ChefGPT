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
            Text("Replace")
//            BottomSheetView()
//                .presentationDetents([.large,.large])
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

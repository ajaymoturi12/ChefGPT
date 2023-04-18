//
//  TabBarItem.swift
//  ChefGPT
//
//  Created by Jalen Wright on 4/10/23.
//

import SwiftUI

struct TabBarItem: View {
    @State var checked = false
    @State var name:String
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color(red:217/255, green:217/255, blue:217/255))
            HStack {
                Text(name)
            }
            .padding()
            
        }.frame(width:325, height:60).cornerRadius(15)
    }
}

struct TabBarItem_Previews: PreviewProvider {
    static var previews: some View {
        TabBarItem(name: "Orange")
    }
}

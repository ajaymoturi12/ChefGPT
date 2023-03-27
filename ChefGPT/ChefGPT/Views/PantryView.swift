//
//  PantryView.swift
//  ChefGPT
//
//  Created by Ethan Fox on 3/13/23.
//

import SwiftUI

struct PantryView: View {
    
    @State private var showingImagePicker = false
    @State private var inputImages:[UIImage] = [UIImage]()
    
    var body: some View {
        ZStack {
            // Content should be here
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Circle()
                        .frame(width: 75)
                        .foregroundColor(.blue)
                        .onTapGesture {
                            showingImagePicker = true
                        }
                }
            }
            .padding()
        }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(images: $inputImages)
        }
    }
}

struct PantryView_Previews: PreviewProvider {
    static var previews: some View {
        PantryView()
    }
}

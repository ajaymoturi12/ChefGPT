//
//  ScanView.swift
//  ChefGPT
//
//  Created by Ethan Fox on 4/8/23.
//

import SwiftUI

struct ScanView: View {
    @State var sheetDisplayed = false
    var body: some View {
        VStack {
            Button {
                sheetDisplayed = true
            } label: {
                Text("Camera")
                    .buttonStyle(.plain)
                    .foregroundColor(.white)
                    .font(.system(.title, design:.rounded, weight: .heavy))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.GPTorange())
            }
            
            Button {
                sheetDisplayed = true
            } label: {
                Text("Photo Library")
                    .buttonStyle(.plain)
                    .foregroundColor(.white)
                    .font(.system(.title, design:.rounded, weight: .heavy))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.GPTdarkGreen())
            }
            Spacer()
        }
        .fullScreenCover(isPresented: $sheetDisplayed) {
            CameraView()
        }
    }
}

struct ScanView_Previews: PreviewProvider {
    static var previews: some View {
        ScanView()
    }
}

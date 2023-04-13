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
        Color.white
            .onAppear() {
                sheetDisplayed = true
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

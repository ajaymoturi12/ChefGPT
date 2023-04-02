//
//  CameraFoodConfirmationView.swift
//  ChefGPT
//
//  Created by Ethan Fox on 4/2/23.
//

import SwiftUI

struct CameraFoodConfirmationView: View {
    
    let image:UIImage
    
    @EnvironmentObject var model: Model
    var body: some View {
        Text("Hello, World!")
    }
}

struct CameraFoodConfirmationView_Previews: PreviewProvider {
    static var previews: some View {
        CameraFoodConfirmationView(image: UIImage())
    }
    
}


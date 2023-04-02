//
//  CameraView.swift
//  DoubleDogDare
//
//  Created by Ethan Fox on 2/21/23.
//

import SwiftUI
import AVFoundation

struct CameraView: View {
    
    @StateObject var camera = CameraModel()
    @State var imageTaken = false
    
    
    
    
    var body: some View {
        ZStack {
            CameraPreview(camera: camera)
                .ignoresSafeArea()
            VStack {
                HStack {
                    Button("Back") {
                        print("What")
                    }
                    .padding()
                    Spacer()
                }
                Spacer()
                
                Button(action: {}/* TODO: write method */) {
                    ZStack {
                        Circle()
                            .fill(Color.white)
                            .frame(width: 65, height: 65)
                        Circle()
                            .stroke(Color.white, lineWidth: 2)
                            .frame(width: 75, height: 75)
                    }
                }
                Button(action: {}/* TODO: write method */ ) {
                    ZStack {
                        Circle()
                            .fill(Color.white)
                            .frame(width: 65, height: 65)
                        Circle()
                            .stroke(Color.white, lineWidth: 2)
                            .frame(width: 75, height: 75)
                    }
                }
            }
        }
        .onAppear {
            camera.check()
        }
    }
}

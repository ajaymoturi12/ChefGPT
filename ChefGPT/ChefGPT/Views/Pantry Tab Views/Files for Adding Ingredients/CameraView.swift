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
    @State var showModal = false
    @State var canRetake = false
    @Environment(\.dismiss) var dismiss
    
    
    var body: some View {
        ZStack {
            CameraPreview(camera: camera)
                .ignoresSafeArea()
            
            // This is where the background and frame go
            Color.black.opacity(0.5)
                .reverseMask {
                    Rectangle()
                        .frame(width: 300, height: 300)
                        .cornerRadius(15)
                }
                .ignoresSafeArea()

            VStack {
                HStack {
                    Button(action: dismissMe) {
                        Image(systemName: "xmark")
                            .font(.system(size: 25))
                            .padding(10)
                            .backgroundStyle(.opacity(0.5))
                            .background(.white)
                            .cornerRadius(10)
                    }
                    .buttonStyle(.plain)
                    Spacer()
                }
                Spacer()
                if !canRetake {
                    Button(action: photoTaken ) {
                        ZStack {
                            Circle()
                                .fill(Color.white)
                                .frame(width: 65, height: 65)
                            Circle()
                                .stroke(Color.white, lineWidth: 2)
                                .frame(width: 75, height: 75)
                        }
                    }
                } else {
                    HStack {
                        // can retake
                        Button(action: retake) {
                            Text("retake")
                                .padding([.leading, .trailing], 15)
                                .padding([.top, .bottom], 5)
                                .background(Color.GPTlightGrey())
                                .clipShape(Capsule())
                        }
                        
                        Spacer()
                        Button(action: confirmPhoto) {
                            Text("confirm")
                                .padding([.leading, .trailing], 15)
                                .padding([.top, .bottom], 5)
                                .background(Color.GPTlightGrey())
                                .clipShape(Capsule())
                        }
                    }
                }
                
            }
            .padding()
        }
        .onAppear {
            camera.check()
        }
        .sheet(isPresented: $showModal) {
            let image = UIImage(data: camera.pictureData)!
            BottomSheetView(image: image, classification: ImageClassifier.classify(image: image))
                .presentationDetents([.fraction(0.8)])
        }
    }
    
    func photoTaken() {
        camera.takePic()
        canRetake = true
    }
    
    func retake() {
        camera.retakePhoto()
        canRetake = false
    }
    
    func confirmPhoto() {
        showModal = true
    }
    
    func dismissMe() {
        dismiss()
    }
}


struct CameraView_Previews: PreviewProvider {
    static var previews: some View {
        CameraView()
    }
}


extension View {
    @inlinable
    public func reverseMask<Mask: View>(
        alignment: Alignment = .center,
        @ViewBuilder _ mask: () -> Mask
    ) -> some View {
        self.mask {
            Rectangle()
                .overlay(alignment: alignment) {
                    mask()
                        .blendMode(.destinationOut)
                }
        }
    }
}

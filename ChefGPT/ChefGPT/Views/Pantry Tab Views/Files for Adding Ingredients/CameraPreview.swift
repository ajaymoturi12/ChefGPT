//
//  CameraPreview.swift
//  DoubleDogDare
//
//  Created by Ethan Fox on 2/21/23.
//

import SwiftUI
import AVFoundation


struct CameraPreview: UIViewRepresentable {
    
    @ObservedObject var camera: CameraModel
    
    func makeUIView(context: Context) -> UIView {
        
        let view = UIView(frame: UIScreen.main.bounds)
        
        camera.preview = AVCaptureVideoPreviewLayer(session: camera.session)
        camera.preview.frame = view.frame
        
        
        camera.preview.videoGravity = .resizeAspectFill
        view.layer.addSublayer(camera.preview)
        
        camera.session.startRunning()
        
        return view
    }
    
    
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
}

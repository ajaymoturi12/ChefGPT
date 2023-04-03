//
//  ImageClassifier.swift
//  ChefGPT
//
//  Created by Ethan Fox on 3/30/23.
//

import Foundation
import Vision
import UIKit

public class ImageClassifier {
    
    static func createImageClassifier(image:UIImage) -> [VNClassificationObservation]? {
        let defaultConfig = MLModelConfiguration()
        guard let pixelBuffer: CVPixelBuffer = buffer(image:image) else { return nil}
        guard let model = try? VNCoreMLModel(for: IngredientClassifier(configuration: defaultConfig).model) else { return nil}
        
        let request = VNCoreMLRequest(model: model) { (data, error) in {
                    // Checks if the data is in the correct format and assigns it to results
                    guard let results = data.results as? [VNClassificationObservation] else { return []}
                    // Assigns the first result (if it exists) to firstObject
                    return results
                }
            }
        try? VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:]).perform([request])
        }
        
    
    static private func buffer(image: UIImage) -> CVPixelBuffer? {
      let attrs = [kCVPixelBufferCGImageCompatibilityKey: kCFBooleanTrue, kCVPixelBufferCGBitmapContextCompatibilityKey: kCFBooleanTrue] as CFDictionary
      var pixelBuffer : CVPixelBuffer?
      let status = CVPixelBufferCreate(kCFAllocatorDefault, Int(image.size.width), Int(image.size.height), kCVPixelFormatType_32ARGB, attrs, &pixelBuffer)
      guard (status == kCVReturnSuccess) else {
        return nil
      }

      CVPixelBufferLockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))
      let pixelData = CVPixelBufferGetBaseAddress(pixelBuffer!)

      let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
      let context = CGContext(data: pixelData, width: Int(image.size.width), height: Int(image.size.height), bitsPerComponent: 8, bytesPerRow: CVPixelBufferGetBytesPerRow(pixelBuffer!), space: rgbColorSpace, bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue)

      context?.translateBy(x: 0, y: image.size.height)
      context?.scaleBy(x: 1.0, y: -1.0)

      UIGraphicsPushContext(context!)
      image.draw(in: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
      UIGraphicsPopContext()
      CVPixelBufferUnlockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))

      return pixelBuffer
    }
    
}

//
//  ImageClassifier.swift
//  ChefGPT
//
//  Created by Ajay Moturi on 3/30/23.
//

import Foundation
import Vision
import UIKit

struct ClassificationData {
    let identifier: String
    let confidence: Double
}

typealias ClassificationCompletionHandler = (([ClassificationData]) -> Void)

public class ImageClassifier {
    private var coreModel: VNCoreMLModel?
    private(set) var classificationRequest: VNCoreMLRequest?
    var completionHandler: ClassificationCompletionHandler? = nil
    
    func createImageClassifier() -> Void {
        let defaultConfig = MLModelConfiguration()
        //defaultConfig.computeUnits = MLComputeUnits.cpuOnly
        
        do {
            //let model = try IngredientClassifier(model: <#T##MLModel#>)
            let model = try VNCoreMLModel(for: IngredientClassifier(configuration: defaultConfig).model)
            self.coreModel = model
            
        } catch {
            print("Failed to load Vision ML model: \(error)")
        }
    }
    
    func setupClassificationRequest() {
        let coreModel = self.coreModel!
        let request = VNCoreMLRequest(model: coreModel) { [weak self] request, error in
            self?.processClassifications(for: request, error: error)
        }
        request.imageCropAndScaleOption = .centerCrop
        self.classificationRequest = request
    }
    
    func getClassifications(for image: UIImage,
                            completionHandler: @escaping ClassificationCompletionHandler) {

        guard let classificationRequest = self.classificationRequest else {
            print("Failed to perform classification.")
            return
        }

        // remember completion handler for later
        self.completionHandler = completionHandler

        // feed the orientation information since CGImage can't read UIImage orientation
        let imageOrientation = image.imageOrientation.rawValue
        guard let orientation = CGImagePropertyOrientation(rawValue: UInt32(imageOrientation)),
              let ciImage = CIImage(image: image) else {
            print("Unable to create \(CIImage.self) from \(image).")
            return
        }

        DispatchQueue.global(qos: .userInitiated).async {
            let handler = VNImageRequestHandler(ciImage: ciImage,
                                                orientation: orientation)
            
            do {
                try handler.perform([classificationRequest])
            }
            catch {
                // check VNCoreMLRequest's completion block for detailed error
                print("Failed to perform classification.\n\(error.localizedDescription)")
            }
        }
    }
        
    private func processClassifications(for request: VNRequest, error: Error?) {
        guard let results = request.results,
              let classifications = results as? [VNClassificationObservation],
              !classifications.isEmpty else {
            print("Unable to classify image.\n\(String(describing: error?.localizedDescription))")
            return
        }

        print(results)
        
        /// limit classification results count to 5 instead of 1000.
        let firstClassifications = classifications.prefix(5)
        var requestedClassifications = [ClassificationData]()
        firstClassifications.forEach { (observation) in
            let data = ClassificationData(identifier: observation.identifier,
                                          confidence: Double(observation.confidence))
            requestedClassifications.append(data)
        }
        print("Fetched requested classifications: \(requestedClassifications)")
        completionHandler?(requestedClassifications)
    }
    
//    func test() {
//        let classifier = ImageClassifier()
//        classifier.createImageClassifier()
//        classifier.setupClassificationRequest()
//        
//        let image = UIImage(named: "banana")
//        do {
//            try classifier.getClassifications(for: image!) { (results) in
//                DispatchQueue.main.async { [weak self] in
//                    let _ = print("results")
//                }
//            }
//        }
//        catch {
//            let _ = print("\(error)")
//        }
//    }
    
    private func buffer(image: UIImage) -> CVPixelBuffer? {
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

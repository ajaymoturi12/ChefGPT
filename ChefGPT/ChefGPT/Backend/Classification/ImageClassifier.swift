//
//  ImageClassifier.swift
//  ChefGPT
//  Created by Ajay Moturi on 3/30/23.
//

import Foundation
import UIKit
import CoreML

public class ImageClassifier {
    static func classify(image: UIImage?) {
        guard let buffer = image?.resize(size: CGSize(width: 224, height: 224))?
                        .getCVPixelBuffer() else {
                    return
                }
        
        do {
            let defaultConfig = MLModelConfiguration()
            let model = try IngredientClassifier(configuration: defaultConfig)
            let input = IngredientClassifierInput(image: buffer)
            let pred = try model.prediction(input: input)
            var probs = pred.classLabelProbs
            
            var ret = [String:Double]()
            for _ in 0...3 {
                let max = probs.values.max()
                if let key = probs.first(where: { $0.value == max })?.key {
                    ret[key] = max
                    probs.removeValue(forKey: key)
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func test() {
        let classifier = ImageClassifier()
        let image = UIImage(named: "banana")
        ImageClassifier.classify(image: image!)
    }
    
}

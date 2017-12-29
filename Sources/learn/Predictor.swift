//
//  Predictor.swift
//  learn
//
//  Created by Andrea Tomarelli on 29/12/17.
//

import Cocoa
import Neural

class Predictor {
    
    private let network: NeuralNetwork
    
    
    init(networkPath: String) throws {
        let data = try Data(contentsOf: URL(fileURLWithPath: networkPath))
        self.network = try PropertyListDecoder().decode(NeuralNetwork.self, from: data)
    }
    

    func predict(imagePath: String) {
        guard let image = NSImage(contentsOfFile: imagePath) else {
            print("Could not load image file")
            exit(1)
        }
        
        guard Int(image.size.width * image.size.height) == network.networkInfo.inputSize else {
            print("Image size and network input size do not match")
            exit(1)
        }
        
        guard let imageData = image.tiffRepresentation.flatMap(NSBitmapImageRep.init)?.bitmapData else {
            print("Could not extract image data")
            exit(1)
        }
        
        (0 ..< network.networkInfo.inputSize).forEach({ print(imageData[$0]) })
        let input = (0 ..< network.networkInfo.inputSize).map({ Double(imageData[$0]) / 255 })
        let prediction = network.predict(input: input)
        let number = prediction.enumerated().max(by: { $1.1 > $0.1 })!.offset
        
        print("Prediction is:", prediction, number)
    }
    
}

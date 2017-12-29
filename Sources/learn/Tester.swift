//
//  Tester.swift
//  learn
//
//  Created by Andrea Tomarelli on 29/12/17.
//

import Neural

class Tester {

    private let images: IdxFile
    
    private let labels: IdxFile
    
    
    init?(imagesPath: String, labelsPath: String) {
        guard let images = IdxFile(path: imagesPath) else {
            print("Could not load idx image file")
            return nil
        }
        
        guard let labels = IdxFile(path: labelsPath) else {
            print("Could not load idx labels file")
            return nil
        }
        
        guard images.dimensions.count == 3 else {
            print("Images file must have 3 dimensions")
            return nil
        }
        
        guard labels.dimensions.count == 1 else {
            print("Labels file must have 1 dimension")
            return nil
        }
        
        guard images.dimensions[0] == labels.dimensions[0] else {
            print("Images and labels file have different size")
            return nil
        }
        
        self.images = images
        self.labels = labels
    }
    
    
    func test(network: NeuralNetwork) {
        var errors = 0
        
        for i in 0 ..< images.dimensions[0] {
            let networkPrediction = network.predict(input: images[i].map({ Double($0) / 255 }))

            let prediction = networkPrediction.enumerated().max(by: { $1.1 > $0.1 })!.offset
            let expectation = labels[i][0]
            
            if prediction != expectation {
                errors += 1
                print("Test error:", i, prediction, expectation)
            }
        }
        
        print("Total errors:", errors)
    }
    
}

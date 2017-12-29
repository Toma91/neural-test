//
//  Trainer.swift
//  learn
//
//  Created by Andrea Tomarelli on 29/12/17.
//

import Foundation
import Neural

class Trainer {
    
    private let images: IdxFile
    
    private let labels: IdxFile
    
    let epochs:         Int
    
    let batchSize:      Int
    
    let eta:            Double

    
    init?(imagesPath: String, labelsPath: String, epochs: Int, batchSize: Int, eta: Double) {
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

        guard labels.dimensions.count == 3 else {
            print("Labels file must have 1 dimension")
            return nil
        }
        
        guard images.dimensions[0] == labels.dimensions[0] else {
            print("Images and labels file have different size")
            return nil
        }

        self.images     = images
        self.labels     = labels
        self.epochs     = epochs
        self.batchSize  = batchSize
        self.eta        = eta
    }
    
    
    func train(outputFile: String) throws -> NeuralNetwork {
        let network = NeuralNetwork(
            networkInfo: NetworkInfo(
                inputSize: images.dimensions.suffix(from: 1).reduce(1, *),
                hiddenLayers: 2,
                hiddenLayerSize: 16,
                outputSize: 10
            )
        )
        
        let trainingSet = TrSet(fi: images, fl: labels)
        
        let d = Date()
        network.train(withSet: trainingSet, epochs: epochs, batchSize: batchSize, eta: eta)
        print("training time (s):", Date().timeIntervalSince(d))
        
        let data = try PropertyListEncoder().encode(network)
        try data.write(to: URL(fileURLWithPath: outputFile))
    
        return network
    }
    
}

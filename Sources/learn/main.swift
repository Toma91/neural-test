//
//  main.swift
//  learn
//
//  Created by Andrea Tomarelli on 09/12/17.
//

import Darwin.C
import Matrices
import Neural

extension IdxFile: TrainingSet {
  
    private static let expectedOutput: ColumnVector<Double> = ColumnVector(0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0)
    
    public var length: Int {
        return dimensions[0]
    }
    
    public func shuffle() {
        // NO OP
    }
    
    public func batch(ofSize size: Int, atOffset index: Int) -> LazyMapRandomAccessCollection<CountableRange<Int>, TrainingData> {
        return (size * index ..< size * index.advanced(by: 1)).lazy.map {
            (ColumnVector(elements: self[$0].map({ Double($0) / 255 })), IdxFile.expectedOutput)
        }
    }
    
}

guard CommandLine.arguments.count > 1 else {
  print("Usage: learn <file>")
  exit(0)
}

guard let f = IdxFile(path: CommandLine.arguments[1]) else {
  print("Could not load idx file")
  exit(0)
}

let network = NeuralNetwork(
  networkInfo: NetworkInfo(
    inputSize: f.dimensions.suffix(from: 1).reduce(1, *),
    hiddenLayers: 2,
    hiddenLayerSize: 16,
    outputSize: 10
  )
)

network.train(withSet: f, batchSize: 1000, eta: 1)
print(network.predict(input: f[0].map({ Double($0) / 255 })))



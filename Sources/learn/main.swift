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
    
    public typealias MiniBatch = LazyMapRandomAccessCollection<CountableRange<Int>, TrainingData>
    
    public typealias MiniBatchSequence = LazyMapSequence<StrideTo<Int>, MiniBatch>
    
    
    private static let expectedOutput: [Double] = [1, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    
    
    public func shuffle() {
        // NO OP
    }
    
    public func batches(ofSize size: Int) -> MiniBatchSequence {
        return stride(from: 0, to: dimensions[0], by: size).lazy.map {
            self.createMiniBatch(start: $0, size: size)
        }
    }
    
    private func createMiniBatch(start: Int, size: Int) -> MiniBatch {
        let end = min(start.advanced(by: size), dimensions[0])
        
        return (start ..< end).lazy.map(createTrainingData)
    }
    
    private func createTrainingData(index: Int) -> TrainingData {
        return (self[index].map({ Double($0) / 255 }), IdxFile.expectedOutput)
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



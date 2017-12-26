//
//  main.swift
//  learn
//
//  Created by Andrea Tomarelli on 09/12/17.
//

import Darwin.C
import Matrices
import Neural

import Foundation

struct TrSet: TrainingSet {
    
    public typealias MiniBatch = LazyMapRandomAccessCollection<CountableRange<Int>, TrainingData>
    
    public typealias MiniBatchSequence = LazyMapSequence<StrideTo<Int>, MiniBatch>
    
    
    
    public func shuffle() {
        // NO OP
    }
    
    public func batches(ofSize size: Int) -> MiniBatchSequence {
        return stride(from: 0, to: fi.dimensions[0], by: size).lazy.map {
            self.createMiniBatch(start: $0, size: size)
        }
    }
    
    private func createMiniBatch(start: Int, size: Int) -> MiniBatch {
        let end = min(start.advanced(by: size), fi.dimensions[0])
        
        return (start ..< end).lazy.map(createTrainingData)
    }
    
    private func createTrainingData(index: Int) -> TrainingData {
        return (fi[index].map({ Double($0) / 255 }), fl[index].flatMap(createOutput))
    }
    
    private func createOutput(a: UInt8) -> [Double] {
        switch a {
            
        case 0: return [1, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        case 1: return [0, 1, 0, 0, 0, 0, 0, 0, 0, 0]
        case 2: return [0, 0, 1, 0, 0, 0, 0, 0, 0, 0]
        case 3: return [0, 0, 0, 1, 0, 0, 0, 0, 0, 0]
        case 4: return [0, 0, 0, 0, 1, 0, 0, 0, 0, 0]
        case 5: return [0, 0, 0, 0, 0, 1, 0, 0, 0, 0]
        case 6: return [0, 0, 0, 0, 0, 0, 1, 0, 0, 0]
        case 7: return [0, 0, 0, 0, 0, 0, 0, 1, 0, 0]
        case 8: return [0, 0, 0, 0, 0, 0, 0, 0, 1, 0]
        case 9: return [0, 0, 0, 0, 0, 0, 0, 0, 0, 1]
        
        default: preconditionFailure()
            
        }
    }
    
    private let fi: IdxFile

    private let fl: IdxFile

    init(fi: IdxFile, fl: IdxFile) {
        self.fi = fi
        self.fl = fl
    }
    
}

guard CommandLine.arguments.count == 3 else {
    print("Usage: learn <image file> <labels file>")
    exit(0)
}

guard let fi = IdxFile(path: CommandLine.arguments[1]) else {
    print("Could not load idx image file")
    exit(0)
}

guard let fl = IdxFile(path: CommandLine.arguments[2]) else {
    print("Could not load idx labels file")
    exit(0)
}

let network = NeuralNetwork(
    networkInfo: NetworkInfo(
        inputSize: fi.dimensions.suffix(from: 1).reduce(1, *),
        hiddenLayers: 2,
        hiddenLayerSize: 16,
        outputSize: 10
    )
)

let set = TrSet(fi: fi, fl: fl)

let d = Date()
network.train(withSet: set, batchSize: 1000, eta: 1)
print("training time (s):", Date().timeIntervalSince(d))
print(network.predict(input: fi[0].map({ Double($0) / 255 })))



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

let learn = false
let network: NeuralNetwork

if learn {
    network = NeuralNetwork(
        networkInfo: NetworkInfo(
            inputSize: fi.dimensions.suffix(from: 1).reduce(1, *),
            hiddenLayers: 2 * 0,
            hiddenLayerSize: 16,
            outputSize: 10
        )
    )
    
    let set = TrSet(fi: fi, fl: fl)
    
    let d = Date()
    network.train(withSet: set, epochs: 5, batchSize: 1000, eta: 1)
    print("training time (s):", Date().timeIntervalSince(d))
    
    let data = try PropertyListEncoder().encode(network)
    try data.write(to: URL(fileURLWithPath: "/Users/andrea/Desktop/network.structure"))
} else {
    let data = try Data(contentsOf: URL(fileURLWithPath: "/Users/andrea/Desktop/network.structure"))
    network = try PropertyListDecoder().decode(NeuralNetwork.self, from: data)
}

print(network.predict(input: fi[0].map({ Double($0) / 255 })))
print(network.predict(input: fi[101].map({ Double($0) / 255 })))

print(network.predict(input: fi[0].map({ Double($0) / 255 })))





let test_i = IdxFile(path: "/Users/andrea/Desktop/learn/Data/t10k-images.idx3-ubyte")!
let test_l = IdxFile(path: "/Users/andrea/Desktop/learn/Data/t10k-labels.idx1-ubyte")!

var errors = 0

for i in 0 ..< 10_000 {
    let _pred = network.predict(input: test_i[i].map({ Double($0) / 255 }))
    let pred = _pred.enumerated().max(by: { $1.1 > $0.1 })!.offset
    let _exp = test_l[i][0]
    
    if pred != _exp {
        errors += 1
        print(i, pred, _exp)
    }
}

print("errors:", errors)




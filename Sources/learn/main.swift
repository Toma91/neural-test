//
//  main.swift
//  learn
//
//  Created by Andrea Tomarelli on 09/12/17.
//

import Darwin.C
import Neural

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

let expectedOutput = [1.0, 2, 3, 4, 5, 6, 7, 8, 9, 10].map { $0 / 10 }

let trainingSet = (0 ..< f.dimensions[0]).map {
    (data: f[$0].map({ Double($0) / 255 }), expectedOutput: expectedOutput)
}

network.train(withSet: trainingSet, batchSize: 1000, eta: 1)
print(network.predict(input: f[0].map({ Double($0) / 255 })))



//
//  main.swift
//  learn
//
//  Created by Andrea Tomarelli on 09/12/17.
//

import Darwin.C

guard CommandLine.arguments.count > 1 else {
    print("Usage: learn <command> <arguments>...")
    exit(0)
}

switch CommandLine.arguments[1] {
    
case "train":
    guard CommandLine.arguments.count == 6 else {
        print("Usage: learn train <training images file> <training labels file> <test images file> <test labels file>")
        exit(0)
    }

    guard
        let trainer = Trainer(imagesPath: CommandLine.arguments[2], labelsPath: CommandLine.arguments[3]),
        let tester = Tester(imagesPath: CommandLine.arguments[4], labelsPath: CommandLine.arguments[5])
        else { exit(1) }

    let network = try trainer.train(outputFile: "/Users/andrea/Desktop/network.structure")
    tester.test(network: network)
    
case "predict":
    guard CommandLine.arguments.count == 4 else {
        print("Usage: learn predict <network structure> <image>")
        exit(0)
    }

    let predictor = try Predictor(networkPath: CommandLine.arguments[2])
    predictor.predict(imagePath: CommandLine.arguments[3])
    
default:
    print("Invalid command '\(CommandLine.arguments[1])'")
    exit(1)

}



/*



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
    let trainer = Trainer(imagesPath: "", labelsPath: "fl")
    network = (try trainer?.train(outputFile: "/Users/andrea/Desktop/network.structure"))!
} else {
    let data = try Data(contentsOf: URL(fileURLWithPath: "/Users/andrea/Desktop/network.structure"))
    network = try PropertyListDecoder().decode(NeuralNetwork.self, from: data)
}

print(network.predict(input: fi[0].map({ Double($0) / 255 })))
print(network.predict(input: fi[101].map({ Double($0) / 255 })))
if ({ learn }()) { exit(0) }
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

*/


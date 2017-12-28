//
//  NeuralNetwork.swift
//  Neural
//
//  Created by Andrea Tomarelli on 09/12/17.
//

import Darwin.C
import Matrices

import Cocoa

public class NeuralNetwork {

    public let networkInfo: NetworkInfo

    private var neurons:    [ColumnVector<Double>]
    
    private var weights:    [Matrix<Double>]

    private var biases:     [ColumnVector<Double>]
    
    
    public init(networkInfo: NetworkInfo) {
        var neurons: [ColumnVector<Double>] = [ColumnVector(length: networkInfo.inputSize)]
        var weights: [Matrix<Double>]       = []
        var biases: [ColumnVector<Double>]  = []
        
        let hidden = Array(repeating: networkInfo.hiddenLayerSize, count: networkInfo.hiddenLayers)
        
        zip([networkInfo.inputSize] + hidden, hidden + [networkInfo.outputSize]).forEach {
            neurons.append(ColumnVector(length: $1))
            weights.append(Matrix(nRows: $1, nColumns: $0))
            biases.append(ColumnVector(length: $1))
        }
        
        self.networkInfo    = networkInfo
        self.neurons        = neurons
        self.weights        = weights
        self.biases         = biases
    }
    
}

public extension NeuralNetwork {
        
    func train<TS: TrainingSet>(withSet trainingSet: TS, batchSize: Int, eta: Double) {
        fillNeuronsRandom()
        fillWeightsRandom()
        fillBiasesRandom()

        trainingSet.shuffle()

        for (i, miniBatch) in trainingSet.batches(ofSize: batchSize).enumerated() {
            print("batch \(i)")
            miniBatchTrain(miniBatch: miniBatch, eta: eta)
        }
        
        print("***  weights  ***")
        
        for (i, w) in weights.enumerated() {
            let img = NSImage(size: NSSize(width: w.nColumns, height: w.nRows))
            
            img.lockFocus()
            for r in 0 ..< w.nRows {
                for c in 0 ..< w.nColumns {
                    print(i, w[row: r, column: c])
                    let col = CGFloat(max(0,  min(w[row: r, column: c], 1)))
                    NSColor(white: col, alpha: 1.0).set()
                    NSBezierPath(rect: NSRect(x: c, y: r, width: 1, height: 1)).fill()
                }
            }
            img.unlockFocus()
            
            let cgRef = img.cgImage(forProposedRect: nil, context: nil, hints: nil)!
            let bitmapRep = NSBitmapImageRep(cgImage: cgRef)
            bitmapRep.size = img.size
            let pngData = bitmapRep.representation(using: .png, properties: [:])!
            try! pngData.write(to: URL(fileURLWithPath: "/Users/andrea/Desktop/w_\(i).png"))
        }
        
        print("***  biases  ***")

        for (i, b) in biases.enumerated() {
            let img = NSImage(size: NSSize(width: 1, height: b.length))
            
            img.lockFocus()
            for j in 0 ..< b.length {
                print(i, b[j])
                let col = CGFloat(max(0,  min(b[j], 1)))
                NSColor(white: col, alpha: 1.0).set()
                NSBezierPath(rect: NSRect(x: 0, y: j, width: 1, height: 1)).fill()
            }
            img.unlockFocus()
            
            let cgRef = img.cgImage(forProposedRect: nil, context: nil, hints: nil)!
            let bitmapRep = NSBitmapImageRep(cgImage: cgRef)
            bitmapRep.size = img.size
            let pngData = bitmapRep.representation(using: .png, properties: [:])!
            try! pngData.write(to: URL(fileURLWithPath: "/Users/andrea/Desktop/b_\(i).png"))
        }
    }

    
    private func miniBatchTrain<C: Collection>(miniBatch: C, eta: Double) where C.Element == TrainingSet.TrainingData, C.IndexDistance == Int {
        var nablas_w = weights.reversed().map { Matrix<Double>.zeros(nRows: $0.nRows, nColumns: $0.nColumns) }
        var nablas_b = biases.reversed().map { ColumnVector<Double>.zeros(length: $0.length) }

        var delta = ColumnVector<Double>()
        var nabla_w = Matrix<Double>()
        var nabla_b = ColumnVector<Double>()
        
        for (input, expectedOutput) in miniBatch {
            let predictedOutput = predict(input: input)

            delta <~ 2 * (ColumnVector(elements: predictedOutput) - ColumnVector(elements: expectedOutput))

            for (index, layer) in stride(from: networkInfo.hiddenLayers, through: 0, by: -1).enumerated() {
                nabla_b <~ σ̇(weights[layer] • neurons[layer] + biases[layer]) * delta
                nabla_w <~ nabla_b • neurons[layer].ᵀ
                delta <~ weights[layer].ᵀ • nabla_b

                nablas_w[index] += nabla_w
                nablas_b[index] += nabla_b
            }
        }
        
        let len = Double(miniBatch.count)

        for i in 0 ..< nablas_w.count {
            weights[nablas_w.count - i - 1] -= nablas_w[i] * (eta / len)
        }
        
        for i in 0 ..< nablas_b.count {
            biases[nablas_b.count - i - 1] -= nablas_b[i] * (eta / len)
        }
    }
    
}

private extension NeuralNetwork {
    
    func fillNeuronsRandom() {
        for i in 0 ..< neurons.count {
            for j in 0 ..< neurons[i].length {
                neurons[i][j] = Double(arc4random()) / Double(UInt32.max)
            }
        }
    }

    func fillWeightsRandom() {
        for i in 0 ..< weights.count {
            for j in 0 ..< weights[i].nRows {
                for k in 0 ..< weights[i].nColumns {
                    weights[i][row: j, column: k] = Double(arc4random()) / Double(UInt32.max)
                }
            }
        }
    }
    
    func fillBiasesRandom() {
        for i in 0 ..< biases.count {
            for j in 0 ..< biases[i].length {
                biases[i][j] = Double(arc4random()) / Double(UInt32.max)
            }
        }
    }

}

public extension NeuralNetwork {
    
    func predict(input: [Double]) -> [Double] {
        precondition(
            input.count == networkInfo.inputSize,
            "Wrong input size, expected \(networkInfo.inputSize), got \(input.count)"
        )

        input.enumerated().forEach { neurons[0][$0] = $1 }
        
        for layer in (0 ... networkInfo.hiddenLayers) {
            neurons[layer + 1] <~ σ(weights[layer] • neurons[layer] + biases[layer])
        }

        return Array(vector: neurons.last!)
    }
    
}

private extension NeuralNetwork {
    
    func σ(_ v: ColumnOperation2<Double>) -> ColumnOperation1<Double> {
        return ColumnOperation1(vector: v) {
            1 / (1 + exp($0))
        }
    }
    
    func σ̇(_ v: ColumnOperation2<Double>) -> ColumnOperation1<Double> {
        return ColumnOperation1(vector: v) {
            exp($0) / ((1 + exp($0)) * (1 + exp($0)))
        }
    }

}

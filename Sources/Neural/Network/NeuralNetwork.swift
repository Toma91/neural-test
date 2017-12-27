//
//  NeuralNetwork.swift
//  Neural
//
//  Created by Andrea Tomarelli on 09/12/17.
//

import Darwin.C
import Matrices

import Foundation

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
                
        for miniBatch in trainingSet.batches(ofSize: batchSize) {
            miniBatchTrain(miniBatch: miniBatch, eta: eta)
        }        
    }

    private func miniBatchTrain<C: Collection>(miniBatch: C, eta: Double) where C.Element == TrainingSet.TrainingData {
        let __d = Date()
        
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
        
        for i in 0 ..< nablas_w.count {
            weights[nablas_w.count - i - 1] -= nablas_w[i] / (eta * Double(nablas_w.count))
        }
        
        for i in 0 ..< nablas_b.count {
            biases[nablas_b.count - i - 1] -= nablas_b[i] / (eta * Double(nablas_b.count))
        }
        
        print(Date().timeIntervalSince(__d))
        exit(0)
    }
    
}

private extension NeuralNetwork {
    
    func fillNeuronsRandom() {
        for i in 0 ..< neurons.count {
            for j in 0 ..< neurons[i].length {
                neurons[i][j] = Double(arc4random()) / Double(UInt32.max) * 0
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

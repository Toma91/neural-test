//
//  NeuralNetwork.swift
//  Neural
//
//  Created by Andrea Tomarelli on 09/12/17.
//

import Darwin.C
import Matrices

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
        trainingSet.shuffle()
        
        for i in 0 ..< trainingSet.length / batchSize {
            miniBatchTrain(miniBatch: trainingSet.batch(ofSize: batchSize, atOffset: i), eta: eta)
        }
    }

    private func miniBatchTrain<C: Collection>(miniBatch: C, eta: Double) where C.Element == TrainingSet.TrainingData {
        for i in 0 ..< neurons.count {
            for j in 0 ..< neurons[i].length {
                neurons[i][j] = Double(arc4random()) / Double(UInt32.max)
            }
        }
        
        for i in 0 ..< biases.count {
            for j in 0 ..< biases[i].length {
                biases[i][j] = Double(arc4random()) / Double(UInt32.max)
            }
        }
        
        for i in 0 ..< weights.count {
            for j in 0 ..< weights[i].nRows {
                for k in 0 ..< weights[i].nColumns {
                    weights[i][row: j, column: k] = Double(arc4random()) / Double(UInt32.max)
                }
            }
        }
    }
 
    /*private func miniBatchTrain(miniBatch: ArraySlice<TrainingData>, eta: Double) {
        for (trainingData, expectedOutput) in miniBatch {
            let predictedOutput = predict(input: trainingData)
            
            let deZ_deW_0 = input(forLayer: networkInfo.hiddenLayers)[0]
            let deA_deZ_0 = weights(forLayer: networkInfo.hiddenLayers, stage: 0) * input(forLayer: networkInfo.hiddenLayers)
                + bias(forLayer: networkInfo.hiddenLayers, stage: 0)
            let deC_deA_0 = 2 * zip(predictedOutput, expectedOutput).map({ ($0 - $1) * ($0 - $1) }).reduce(0, +)
            let deC_deW_0 = deZ_deW_0 * deA_deZ_0 * deC_deA_0
            
            print(deC_deW_0)
            print()
        }
    }*/
    
    /*private func cost(output: [Double], expected: [Double]) -> Double {
        return zip(output, expected)
            .map { ($0 - $1) * ($0 - $1) }
            .reduce(0, +)
    }*/
    
}

public extension NeuralNetwork {
    
    func predict(input: [Double]) -> [Double] {
        precondition(
            input.count == networkInfo.inputSize,
            "Wrong input size, expected \(networkInfo.inputSize), got \(input.count)"
        )

        input.enumerated().forEach { neurons[0][$0] = $1 }
        (0 ... networkInfo.hiddenLayers).forEach(predictLayer)

        return Array(vector: neurons.last!)
    }
    
    private func predictLayer(atIndex layer: Int) {
        assert(layer >= 0 && layer <= networkInfo.hiddenLayers)

        neurons[layer + 1] <~ σ(weights[layer] * neurons[layer] + biases[layer])
    }
    
}

private extension NeuralNetwork {
    
    func σ<V: ColumnVectorType>(_ v: V) -> ColumnMap<Double> where V.T == Double {
        return ColumnMap(vector: v) { 1 / (1 + exp(-$0)) }
    }
    
    func squishifyDerivative(_ v: Double) -> Double {
        return exp(v) / ((1 + exp(v)) * (1 + exp(v)))
    }

}

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
    
    private let weights:    [Matrix<Double>]

    private let biases:     [ColumnVector<Double>]
    
    
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

/*public extension NeuralNetwork {
    
    typealias TrainingData = (data: [Double], expectedOutput: [Double])
    
    func train(withSet trainingSet: [TrainingData], batchSize: Int, eta: Double) {
        let ts = trainingSet.shuffled()
        
        for i in stride(from: 0, to: ts.count, by: batchSize) {
            let j = ts.index(i, offsetBy: batchSize, limitedBy: ts.endIndex) ?? ts.endIndex
            miniBatchTrain(miniBatch: ts[i ..< j], eta: eta)
        }
    }
    
    private func miniBatchTrain(miniBatch: ArraySlice<TrainingData>, eta: Double) {
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
    }
    
    /*private func cost(output: [Double], expected: [Double]) -> Double {
        return zip(output, expected)
            .map { ($0 - $1) * ($0 - $1) }
            .reduce(0, +)
    }*/
    
}*/

public extension NeuralNetwork {
    
    func predict(input: [Double]) -> [Double] {
        precondition(
            input.count == networkInfo.inputSize,
            "Wrong input size, expected \(networkInfo.inputSize), got \(input.count)"
        )

        input.enumerated().forEach { neurons[0][$0] = $1 }
        (0 ... networkInfo.hiddenLayers).forEach(predictLayer)

        exit(0)
        //return Array(neurons.suffix(networkInfo.outputSize))
    }
    
    private func predictLayer(atIndex layer: Int) {
        assert(layer >= 0 && layer <= networkInfo.hiddenLayers)

        neurons[layer + 1] <~ squishify(weights[layer] * neurons[layer] + biases[layer])

        /*for i in 0 ..< neurons[layer + 1].length {
            neurons[layer + 1][i] = squishify(weights[layer][row: i] * neurons[layer] + biases[layer][i])
        }*/
        
        
        
        /*let a = input(forLayer: layer)
        
        let size = layer == networkInfo.hiddenLayers
            ? networkInfo.outputSize
            : networkInfo.hiddenLayerSize

        for i in 0 ..< size {
            let w = weights(forLayer: layer, stage: i)
            let b = bias(forLayer: layer, stage: i)
            
            neurons[networkInfo.hiddenLayerSize * layer + i] = squishify(w * a + b)
        }*/
    }
    
}

private extension NeuralNetwork {
/*
    func weights(forLayer layer: Int, stage: Int) -> UnsafeBufferPointer<Double> {
        assert(layer >= 0 && layer <= networkInfo.hiddenLayers)
        
        if layer == 0 {
            return UnsafeBufferPointer(
                rebasing: weights.slice(
                    from: networkInfo.inputSize * stage,
                    count: networkInfo.inputSize
                )
            )
        } else {
            return UnsafeBufferPointer(
                rebasing: weights.slice(
                    from: networkInfo.inputSize * networkInfo.hiddenLayerSize
                        + networkInfo.hiddenLayerSize * (networkInfo.hiddenLayerSize * layer.advanced(by: -1))
                        + networkInfo.hiddenLayerSize * stage,
                    count: networkInfo.hiddenLayerSize
                )
            )
        }
    }
    
    func bias(forLayer layer: Int, stage: Int) -> Double {
        assert(layer >= 0 && layer <= networkInfo.hiddenLayers)

        return biases[networkInfo.hiddenLayerSize * layer + stage]
    }
*/
    func squishify<V: ColumnVectorType>(_ v: V) -> ColumnMap<Double> where V.T == Double {
        return ColumnMap(vector: v) { 1 / (1 + exp(-$0)) }
    }
    
    func squishifyDerivative(_ v: Double) -> Double {
        return exp(v) / ((1 + exp(v)) * (1 + exp(v)))
    }

}

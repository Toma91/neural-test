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
                
        for miniBatch in trainingSet.batches(ofSize: batchSize) {
            miniBatchTrain(miniBatch: miniBatch, eta: eta)
        }        
    }

    private func miniBatchTrain<C: Collection>(miniBatch: C, eta: Double) where C.Element == TrainingSet.TrainingData {
        fillNeuronsRandom()
        fillWeightsRandom()
        fillBiasesRandom()
        
        var trainingResults = miniBatch.reduce(into: []) { (carry: inout Array<(MatrixMap<Double>, ColumnMap<Double>)>, arg1: TrainingSet.TrainingData) in
            let (input, expectedOutput) = arg1
            
            let predictedOutput = predict(input: input)
            var delta = 2 * (ColumnVector(elements: predictedOutput) - ColumnVector(elements: expectedOutput))
            
            for (index, layer) in stride(from: networkInfo.hiddenLayers, through: 0, by: -1).enumerated() {
                let nabla_b = nonLinearityDerivative(weights[layer] * neurons[layer] + biases[layer]) * delta
                let nabla_w = nabla_b * transpose(neurons[networkInfo.hiddenLayers])
                delta = transpose(weights[networkInfo.hiddenLayers]) * nabla_b
                
                if carry.isEmpty {
                    carry.append((1 * nabla_w, nabla_b))
                } else {
                    carry[index].0 = carry[index].0 + nabla_w
                    carry[index].1 = carry[index].1 + nabla_b
                }
            }
        }
        
        for i in 0 ..< trainingResults.count {
            trainingResults[i].0 = trainingResults[i].0 / Double(trainingResults.count)
            trainingResults[i].1 = trainingResults[i].1 / Double(trainingResults.count)
        }
        
        print(trainingResults)
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
        (0 ... networkInfo.hiddenLayers).forEach(predictLayer)

        return Array(vector: neurons.last!)
    }
    
    private func predictLayer(atIndex layer: Int) {
        assert(layer >= 0 && layer <= networkInfo.hiddenLayers)

        neurons[layer + 1] <~ nonLinearity(weights[layer] * neurons[layer] + biases[layer])
    }
    
}

private extension NeuralNetwork {
    
    func nonLinearity<V: ColumnVectorType>(_ v: V) -> ColumnMap<Double> where V.T == Double {
        return ColumnMap(vector: v) { 1 / (1 + exp(-$0)) }
    }
    
    func nonLinearityDerivative<V: ColumnVectorType>(_ v: V) -> ColumnMap<Double> where V.T == Double {
        return ColumnMap(vector: v) { exp($0) / ((1 + exp($0)) * (1 + exp($0))) }
    }

}

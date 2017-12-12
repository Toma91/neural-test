//
//  NeuralNetwork.swift
//  Neural
//
//  Created by Andrea Tomarelli on 09/12/17.
//

import Darwin.C

public class NeuralNetwork {

    let networkInfo:        NetworkInfo

    private let neurons:    UnsafeMutableBufferPointer<Double>
    
    private let weights:    UnsafeMutableBufferPointer<Double>

    private let biases:     UnsafeMutableBufferPointer<Double>

    
    public init(networkInfo: NetworkInfo) {
        self.networkInfo    = networkInfo
        self.neurons        = UnsafeMutableBufferPointer.allocate(capacity: networkInfo.neuronsSize)
        self.weights        = UnsafeMutableBufferPointer.allocate(capacity: networkInfo.weightsSize)
        self.biases         = UnsafeMutableBufferPointer.allocate(capacity: networkInfo.biasesSize)
    }
    
    deinit {
        neurons.deallocate()
        weights.deallocate()
        biases.deallocate()
    }
    
}

public extension NeuralNetwork {
    
    typealias TrainingData = (data: [Double], expectedOutput: [Double])
    
    func train(withSet trainingSet: [TrainingData], batchSize: Int, eta: Double) {
        for i in 0 ..< neurons.count {
            neurons[i] = Double(arc4random_uniform(UInt32.max)) / Double(UInt32.max)
        }
        
        for i in 0 ..< weights.count {
            weights[i] = Double(arc4random_uniform(UInt32.max)) / Double(UInt32.max)
        }
        
        for i in 0 ..< biases.count {
            biases[i] = Double(arc4random_uniform(UInt32.max)) / Double(UInt32.max)
        }
        
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
    
}

public extension NeuralNetwork {
    
    func predict(input: [Double]) -> [Double] {
        precondition(
            input.count == networkInfo.inputSize,
            "Wrong input size, expected \(networkInfo.inputSize), got \(input.count)"
        )

        input.enumerated().forEach { neurons[$0] = $1 }
        (0 ... networkInfo.hiddenLayers).forEach(predictLayer)
        
        return Array(neurons.suffix(networkInfo.outputSize))
    }
    
    private func predictLayer(atIndex layer: Int) {
        assert(layer >= 0 && layer <= networkInfo.hiddenLayers)

        let a = input(forLayer: layer)
        
        let size = layer == networkInfo.hiddenLayers
            ? networkInfo.outputSize
            : networkInfo.hiddenLayerSize

        for i in 0 ..< size {
            let w = weights(forLayer: layer, stage: i)
            let b = bias(forLayer: layer, stage: i)
            
            neurons[networkInfo.hiddenLayerSize * layer + i] = squishify(w * a + b)
        }
    }
    
}

private extension NeuralNetwork {
    
    func input(forLayer layer: Int) -> UnsafeBufferPointer<Double> {
        assert(layer >= 0 && layer <= networkInfo.hiddenLayers)
        
        if layer == 0 {
            return UnsafeBufferPointer(
                rebasing: neurons.slice(
                    from: 0,
                    count: networkInfo.inputSize
                )
            )
        } else {
            return UnsafeBufferPointer(
                rebasing: weights.slice(
                    from: networkInfo.inputSize
                        + networkInfo.hiddenLayerSize * layer.advanced(by: -1),
                    count: networkInfo.hiddenLayerSize
                )
            )
        }
    }
    
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
    
    func squishify(_ v: Double) -> Double {
        return 1 / (1 + exp(-v))
    }
    
    func squishifyDerivative(_ v: Double) -> Double {
        return exp(v) / ((1 + exp(v)) * (1 + exp(v)))
    }

}

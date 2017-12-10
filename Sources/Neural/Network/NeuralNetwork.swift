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
    
    func train<TS: Collection>(withSet trainingSet: TS) where TS.Element == (data: InputData, expectedOutput: OutputData) {
        for i in 0 ..< neurons.count {
            neurons[i] = Double(Int(arc4random()) % 1001 - 500) / 500
        }
        
        for i in 0 ..< weights.count {
            weights[i] = Double(Int(arc4random()) % 1001 - 500) / 500
        }
        
        for i in 0 ..< biases.count {
            biases[i] = Double(Int(arc4random()) % 1001 - 500) / 500
        }
        
        for (trainingInput, trainingOutput) in trainingSet {
            precondition(
                trainingInput.count == networkInfo.inputSize && trainingOutput.count == networkInfo.outputSize,
                "Invalid training size (\(trainingInput.count), \(trainingOutput.count)), expected (\(networkInfo.inputSize), \(networkInfo.outputSize))"
            )
            
            let output = predict(input: trainingInput)
            let cost = self.cost(output: output, expected: trainingOutput)
            print("cost", cost)
        }
    }
    
    private func cost<O: Collection, EO: Collection>(output: O, expected: EO) -> Double
        where O.Element == Double, EO.Element == Double {
            
        return zip(output, expected)
            .map { ($0 - $1) * ($0 - $1) }
            .reduce(into: 0, +=)
    }
    
}

public extension NeuralNetwork {
    
    func predict(input: InputData) -> OutputData {
        precondition(
            input.count == networkInfo.inputSize,
            "Wrong input size, expected \(networkInfo.inputSize), got \(input.count)"
        )

        for l in 0 ... networkInfo.hiddenLayers {
            predictLayer(atIndex: l, input: input)
        }
        
        return OutputData(neurons.suffix(networkInfo.outputSize))
    }
    
    private func predictLayer(atIndex layer: Int, input: InputData) {
        precondition(layer >= 0 && layer <= networkInfo.hiddenLayers)

        let a = layer == 0 ? input : self.input(forLayer: layer)
        
        let size = layer == networkInfo.hiddenLayers
            ? networkInfo.outputSize
            : networkInfo.hiddenLayerSize

        for i in 0 ..< size {
            let w = weights(forLayer: layer, stage: i)
            let b = biases[networkInfo.hiddenLayerSize * layer + i]
            
            neurons[networkInfo.hiddenLayerSize * layer + i] = squishify(w * a + b)
        }
    }
    
    private func input(forLayer layer: Int) -> InputData {
        precondition(layer >= 1 && layer <= networkInfo.hiddenLayers)
        
        return InputData(
            UnsafeBufferPointer(
                rebasing: neurons.slice(
                    from: networkInfo.hiddenLayerSize * layer.advanced(by: -1),
                    count: networkInfo.hiddenLayerSize
                )
            )
        )
    }
    
    private func weights(forLayer layer: Int, stage: Int) -> UnsafeBufferPointer<Double> {
        precondition(layer >= 0 && layer <= networkInfo.hiddenLayers)
    
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
    
}

private extension NeuralNetwork {
    
    func squishify(_ v: Double) -> Double {
        return 1 / (1 + exp(-v))
    }
    
}

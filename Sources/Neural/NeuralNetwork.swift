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
    
    typealias TrainingSample = (data: [Double], output: [Double])
    
    func train<S: Sequence>(withSet trainingSet: S) where S.Element == TrainingSample {
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
    
    private func cost(output: [Double], expected: [Double]) -> Double {
        return zip(output, expected)
            .map { ($0 - $1) * ($0 - $1) }
            .reduce(into: 0, +=)
    }
    
}

public extension NeuralNetwork {
    
    func predict(input: [Double]) -> [Double] /* -> Something */ {
        precondition(
            input.count == networkInfo.inputSize,
            "Wrong input size, expected \(networkInfo.inputSize), got \(input.count)"
        )

        for l in 0 ... networkInfo.hiddenLayers {
            predictLayer(atIndex: l, input: input)
        }
        
        return Array(neurons.suffix(networkInfo.outputSize))
    }
    
    private func predictLayer(atIndex layer: Int, input: [Double]) {
        precondition(layer >= 0 && layer <= networkInfo.hiddenLayers)

        let a = layer == 0
            ? input.withUnsafeBufferPointer(Vector.init)
            : self.input(forLayer: layer)
        
        let size = layer == networkInfo.hiddenLayers
            ? networkInfo.outputSize
            : networkInfo.hiddenLayerSize

        for i in 0 ..< size {
            let w = weights(forLayer: layer, stage: i)
            let b = biases[networkInfo.hiddenLayerSize * layer + i]
            
            neurons[networkInfo.hiddenLayerSize * layer + i] = squishify(w * a + b)
        }
    }
    
    private func input(forLayer layer: Int) -> Vector<Double> {
        precondition(layer >= 1 && layer <= networkInfo.hiddenLayers)
        
        return Vector(
            memory: UnsafeBufferPointer(
                rebasing: neurons.slice(
                    from: networkInfo.hiddenLayerSize * layer.advanced(by: -1),
                    count: networkInfo.hiddenLayerSize
                )
            )
        )
    }
    
    private func weights(forLayer layer: Int, stage: Int) -> Vector<Double> {
        precondition(layer >= 0 && layer <= networkInfo.hiddenLayers)
    
        if layer == 0 {
            return Vector(
                memory: UnsafeBufferPointer(
                    rebasing: weights.slice(
                        from: networkInfo.inputSize * stage,
                        count: networkInfo.inputSize
                    )
                )
            )
        } else {
            return Vector(
                memory: UnsafeBufferPointer(
                    rebasing: weights.slice(
                        from: networkInfo.inputSize * networkInfo.hiddenLayerSize
                            + networkInfo.hiddenLayerSize * (networkInfo.hiddenLayerSize * layer.advanced(by: -1))
                            + networkInfo.hiddenLayerSize * stage,
                        count: networkInfo.hiddenLayerSize
                    )
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

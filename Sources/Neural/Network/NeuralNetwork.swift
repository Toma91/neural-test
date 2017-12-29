//
//  NeuralNetwork.swift
//  Neural
//
//  Created by Andrea Tomarelli on 09/12/17.
//

import Darwin.C
import Matrices

import Cocoa

public class NeuralNetwork: Codable {

    public let networkInfo: NetworkInfo

    private var neurons:    [ColumnVector<Double>]
    
    private var weights:    [Matrix<Double>]

    private var biases:     [ColumnVector<Double>]
    
    
    public init(networkInfo: NetworkInfo) {
        var neurons: [ColumnVector<Double>] = [ColumnVector(length: networkInfo.inputSize)]
        var weights: [Matrix<Double>]       = []
        var biases: [ColumnVector<Double>]  = []
        
        //let hidden = Array(repeating: networkInfo.hiddenLayerSize, count: networkInfo.hiddenLayers)
        
        zip([networkInfo.inputSize] + networkInfo.hiddenLayersSizes, networkInfo.hiddenLayersSizes + [networkInfo.outputSize]).forEach {
            neurons.append(ColumnVector(length: $1))
            weights.append(Matrix(nRows: $1, nColumns: $0))
            biases.append(ColumnVector(length: $1))
        }
        
        self.networkInfo    = networkInfo
        self.neurons        = neurons
        self.weights        = weights
        self.biases         = biases
    }
    
    
    private enum CodingKeys: String, CodingKey {
        
        case networkInfo
        case neurons
        case weights
        case biases

    }
    
    private enum NetworkInfoKeys: String, CodingKey {
    
        case inputSize
        case hiddenLayersSizes
        case outputSize
        
    }
    
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let networkInfoValues = try values.nestedContainer(keyedBy: NetworkInfoKeys.self, forKey: .networkInfo)
        
        self.networkInfo = NetworkInfo(
            inputSize: try networkInfoValues.decode(Int.self, forKey: .inputSize),
            hiddenLayersSizes: try networkInfoValues.decode([Int].self, forKey: .hiddenLayersSizes),
//            hiddenLayers: try networkInfoValues.decode(Int.self, forKey: .hiddenLayers),
  //          hiddenLayerSize: try networkInfoValues.decode(Int.self, forKey: .hiddenLayerSize),
            outputSize: try networkInfoValues.decode(Int.self, forKey: .outputSize)
        )
        
        self.neurons = try values.decode([[Double]].self, forKey: .neurons).map {
            ColumnVector<Double>(elements: $0)
        }
        
        self.weights = try values.decode([[Double]].self, forKey: .weights).map {
            var result = Matrix<Double>(nRows: Int($0[0]), nColumns: Int($0[1]))
            var index = 2
            
            for r in 0 ..< result.nRows {
                for c in 0 ..< result.nColumns {
                    result[row: r, column: c] = $0[index]
                    index += 1
                }
            }
            
            return result
        }
        
        self.biases = try values.decode([[Double]].self, forKey: .biases).map {
            ColumnVector<Double>(elements: $0)
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        var networkInfoContainer = container.nestedContainer(keyedBy: NetworkInfoKeys.self, forKey: .networkInfo)

        try networkInfoContainer.encode(networkInfo.inputSize,          forKey: .inputSize)
        try networkInfoContainer.encode(networkInfo.hiddenLayersSizes,  forKey: .hiddenLayersSizes)
//        try networkInfoContainer.encode(networkInfo.hiddenLayerSize,    forKey: .hiddenLayerSize)
        try networkInfoContainer.encode(networkInfo.outputSize,         forKey: .outputSize)

        let neurons = self.neurons.map { (vector) -> [Double] in
            var result: [Double] = []
            
            for i in 0 ..< vector.length {
                result.append(vector[i])
            }
            
            return result
        }
        
        try container.encode(neurons, forKey: .neurons)
        
        let weights = self.weights.map { (matrix) -> [Double] in
            var result: [Double] = [Double(matrix.nRows), Double(matrix.nColumns)]
            
            for r in 0 ..< matrix.nRows {
                for c in 0 ..< matrix.nColumns {
                    result.append(matrix[row: r, column: c])
                }
            }
            
            return result
        }
        
        try container.encode(weights, forKey: .weights)
    
        let biases = self.biases.map { (vector) -> [Double] in
            var result: [Double] = []
            
            for i in 0 ..< vector.length {
                result.append(vector[i])
            }
            
            return result
        }
        
        try container.encode(biases, forKey: .biases)
    }
    
}

public extension NeuralNetwork {
        
    func train<TS: TrainingSet>(withSet trainingSet: TS, epochs: Int, batchSize: Int, eta: Double) {
        fillWeightsRandom()
        fillBiasesRandom()

        trainingSet.shuffle()

        for e in 0 ..< epochs {
            print("epoch \(e)")

            for (i, miniBatch) in trainingSet.batches(ofSize: batchSize).enumerated() {
                print("batch \(i)")

                let itm = miniBatch.first!
                
                let predictedOutputBefore = predict(input: itm.input)
                print("Error (before):", zip(predictedOutputBefore, itm.expectedOutput).map(-).map({ $0 * $0 }).reduce(0, +))

                miniBatchTrain(miniBatch: miniBatch, eta: eta)

                let predictedOutputAfter = predict(input: itm.input)
                print("Error (after):", zip(predictedOutputAfter, itm.expectedOutput).map(-).map({ $0 * $0 }).reduce(0, +))
            }
        }

        
        // ******* images
        
        
        for (i, w) in weights.enumerated() {
            let img = NSImage(size: NSSize(width: w.nColumns, height: w.nRows))
            
            var _max: Double? = nil

            for r in 0 ..< w.nRows {
                for c in 0 ..< w.nColumns {
                    if _max == nil {
                        _max = abs(w[row: r, column: c])
                    } else if abs(w[row: r, column: c]) > _max! {
                        _max = abs(w[row: r, column: c])
                    }
                }
            }
            
            img.lockFocus()
            for r in 0 ..< w.nRows {
                for c in 0 ..< w.nColumns {
                    let col = CGFloat(abs(w[row: r, column: c]) / _max!)
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

        for (i, b) in biases.enumerated() {
            let img = NSImage(size: NSSize(width: 1, height: b.length))
            
            var _max: Double? = nil
            
            for j in 0 ..< b.length {
                if _max == nil {
                    _max = abs(b[j])
                } else if abs(b[j]) > _max! {
                    _max = abs(b[j])
                }
            }
            
            img.lockFocus()
            for j in 0 ..< b.length {
                let col = CGFloat(abs(b[j]) / _max!)
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
            
            let l = networkInfo.hiddenLayersSizes.count

            delta <~ ColumnVector(elements: zip(predictedOutput, expectedOutput).map(-)) * σ̇(weights[l] • neurons[l] + biases[l])
            nabla_w <~ delta • neurons[l].ᵀ
            nabla_b <~ delta
            
            nablas_w[0] += nabla_w
            nablas_b[0] += nabla_b

            for (index, layer) in stride(from: l, through: 0, by: -1).enumerated().dropFirst() {
                delta <~ σ̇(weights[layer] • neurons[layer] + biases[layer]) * (weights[layer + 1].ᵀ • delta)
                nabla_w <~ delta • neurons[layer].ᵀ
                nabla_b <~ delta

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
   
    func random_uniform(min: Double, max: Double) -> Double {
        let r = Double(arc4random()) / Double(UInt32.max)
        
        return (max - min) * r + min
    }
    
    func fillWeightsRandom() {
        for i in 0 ..< weights.count {
            let d = 1 / sqrt(Double(neurons[i].length))

            for j in 0 ..< weights[i].nRows {
                for k in 0 ..< weights[i].nColumns {
                    weights[i][row: j, column: k] = random_uniform(min: -d, max: d)
                }
            }
        }
    }
    
    func fillBiasesRandom() {
        for i in 0 ..< biases.count {
            let d = 1 / sqrt(Double(neurons[i].length))

            for j in 0 ..< biases[i].length {
                biases[i][j] = random_uniform(min: -d, max: d)
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
        
        for layer in (0 ... networkInfo.hiddenLayersSizes.count) {
            neurons[layer + 1] <~ σ(weights[layer] • neurons[layer] + biases[layer])
        }

        return Array(vector: neurons.last!)
    }
    
}

private extension NeuralNetwork {
    
    func σ(_ v: ColumnOperation2<Double>) -> ColumnOperation1<Double> {
        return ColumnOperation1(vector: v) {
            1 / (1 + exp(-$0))
        }
    }
    
    func σ̇(_ v: ColumnOperation2<Double>) -> ColumnOperation1<Double> {
        return ColumnOperation1(vector: v) {
            exp($0) / ((1 + exp($0)) * (1 + exp($0)))
        }
    }

}

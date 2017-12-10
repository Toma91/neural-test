//
//  NetworkInfo.swift
//  Neural
//
//  Created by Andrea Tomarelli on 09/12/17.
//

public struct NetworkInfo {
    
    public let inputSize:       Int

    public let hiddenLayers:    Int
    
    public let hiddenLayerSize: Int
    
    public let outputSize:      Int
    
    
    public var biasesSize: Int {
        return hiddenLayerSize * hiddenLayers + outputSize
    }
    
    public var neuronsSize: Int {
        return hiddenLayerSize * hiddenLayers + outputSize
    }
    
    public var weightsSize: Int {
        return inputSize * hiddenLayerSize
            + hiddenLayerSize * hiddenLayerSize * (hiddenLayers - 1)
            + hiddenLayerSize * outputSize
    }
    
    
    public init(inputSize: Int, hiddenLayers: Int, hiddenLayerSize: Int, outputSize: Int) {
        self.inputSize          = inputSize
        self.hiddenLayers       = hiddenLayers
        self.hiddenLayerSize    = hiddenLayerSize
        self.outputSize         = outputSize
    }

}

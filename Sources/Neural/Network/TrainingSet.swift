//
//  TrainingSet.swift
//  learnPackageDescription
//
//  Created by Andrea Tomarelli on 16/12/17.
//

public protocol TrainingSet {
    
    typealias TrainingData = (input: [Double], expectedOutput: [Double])
    
    associatedtype MiniBatch: Collection where MiniBatch.Element == TrainingData, MiniBatch.IndexDistance == Int

    associatedtype MiniBatchSequence: Sequence where MiniBatchSequence.Element == MiniBatch
    
    func batches(ofSize size: Int) -> MiniBatchSequence
    
}

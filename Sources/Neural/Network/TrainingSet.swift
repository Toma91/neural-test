//
//  TrainingSet.swift
//  learnPackageDescription
//
//  Created by Andrea Tomarelli on 16/12/17.
//

import Matrices

public protocol TrainingSet {
    
    typealias TrainingData = (input: ColumnVector<Double>, output: ColumnVector<Double>)
    
    associatedtype MiniBatch: RandomAccessCollection where MiniBatch.Element == TrainingData
    
    var length: Int { get }
    
    func shuffle()

    func batch(ofSize size: Int, atOffset index: Int) -> MiniBatch
    
}

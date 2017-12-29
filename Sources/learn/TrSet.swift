//
//  TrSet.swift
//  learn
//
//  Created by Andrea Tomarelli on 29/12/17.
//

import Darwin.C
import Neural

extension MutableCollection {

    mutating func shuffle() {
        guard count > 1 else { return }
        
        for (firstUnshuffled, unshuffledCount) in zip(indices, stride(from: count, to: 1, by: -1)) {
            let d: IndexDistance = numericCast(arc4random_uniform(numericCast(unshuffledCount)))
            let i = index(firstUnshuffled, offsetBy: d)
            swapAt(firstUnshuffled, i)
        }
    }
    
}

extension Sequence {

    func shuffled() -> [Element] {
        var result = Array(self)
        result.shuffle()
        return result
    }
    
}

struct TrSet: TrainingSet {
        
    typealias MiniBatch = LazyMapRandomAccessCollection<CountableRange<Int>, TrainingData>
    
    typealias MiniBatchSequence = LazyMapSequence<[Int], MiniBatch>
    
    
    public func batches(ofSize size: Int) -> MiniBatchSequence {
        return stride(from: 0, to: fi.dimensions[0], by: size).shuffled().lazy.map {
            self.createMiniBatch(start: $0, size: size)
        }
    }
    
    private func createMiniBatch(start: Int, size: Int) -> MiniBatch {
        let end = min(start.advanced(by: size), fi.dimensions[0])
        
        return (start ..< end).lazy.map(createTrainingData)
    }
    
    private func createTrainingData(index: Int) -> TrainingData {
        return (fi[index].map({ Double($0) / 255 }), fl[index].flatMap(createOutput))
    }
    
    private func createOutput(a: UInt8) -> [Double] {
        switch a {
            
        case 0: return [1, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        case 1: return [0, 1, 0, 0, 0, 0, 0, 0, 0, 0]
        case 2: return [0, 0, 1, 0, 0, 0, 0, 0, 0, 0]
        case 3: return [0, 0, 0, 1, 0, 0, 0, 0, 0, 0]
        case 4: return [0, 0, 0, 0, 1, 0, 0, 0, 0, 0]
        case 5: return [0, 0, 0, 0, 0, 1, 0, 0, 0, 0]
        case 6: return [0, 0, 0, 0, 0, 0, 1, 0, 0, 0]
        case 7: return [0, 0, 0, 0, 0, 0, 0, 1, 0, 0]
        case 8: return [0, 0, 0, 0, 0, 0, 0, 0, 1, 0]
        case 9: return [0, 0, 0, 0, 0, 0, 0, 0, 0, 1]
            
        default: preconditionFailure()
            
        }
    }
    
    private let fi: IdxFile
    
    private let fl: IdxFile
    
    private let length: Int
    
    private var indices: [Int]
    
    
    init(fi: IdxFile, fl: IdxFile) {
        precondition(fi.dimensions[0] == fl.dimensions[0])
        
        self.fi = fi
        self.fl = fl
        self.length = fi.dimensions[0]
        self.indices = (0 ..< length).shuffled()
    }
    
}

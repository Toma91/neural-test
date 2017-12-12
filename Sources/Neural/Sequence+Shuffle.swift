//
//  Sequence+Shuffle.swift
//  Neural
//
//  Created by Andrea Tomarelli on 10/12/17.
//

import Darwin.C

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

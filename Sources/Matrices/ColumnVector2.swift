//
//  ColumnVector2.swift
//  Matrices
//
//  Created by Andrea Tomarelli on 14/12/17.
//

public struct ColumnVector<T: Numeric> {
 
    private let storage:    Storage<T>

    let length:             Int
    
    
    init(length: Int) {
        self.storage    = Storage(size: length)
        self.length     = length
    }
    
}

extension ColumnVector {
    
    subscript(index: Int) -> T {
        get {
            precondition(index >= 0 && index < length)
            
            return storage[index]
        }
        set {
            precondition(index >= 0 && index < length)
            
            storage[index] = newValue
        }
    }
    
}

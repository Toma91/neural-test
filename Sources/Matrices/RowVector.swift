//
//  RowVector.swift
//  Matrices
//
//  Created by Andrea Tomarelli on 14/12/17.
//

public struct RowVector<T: Numeric> {
 
    private let storage:    Storage<T>

    public let length:      Int
    
    
    init(length: Int) {
        self.storage    = Storage(size: length)
        self.length     = length
    }
    
    public init(elements: [T]) {
        self.storage    = Storage(elements: elements)
        self.length     = elements.count
    }
    
}

public extension RowVector {
    
    init(_ elements: T...) {
        self.init(elements: elements)
    }
    
}

public extension RowVector {
    
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

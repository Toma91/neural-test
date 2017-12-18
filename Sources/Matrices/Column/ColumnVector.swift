//
//  ColumnVector.swift
//  Matrices
//
//  Created by Andrea Tomarelli on 14/12/17.
//

public struct ColumnVector<T: Numeric>: ColumnVectorType {
 
    private var storage:    Storage<T>

    public let length:      Int
    
    
    public init(length: Int) {
        self.storage    = Storage(size: length)
        self.length     = length
    }
    
    public init(elements: [T]) {
        self.storage    = Storage(elements: elements)
        self.length     = elements.count
    }
    
}

public extension ColumnVector {
    
    init(_ elements: T...) {
        self.init(elements: elements)
    }

}

public extension ColumnVector {

    var transposed: RowTransposed<T> {
        return RowTransposed(transposing: self)
    }
    
}

public extension ColumnVector {
    
    subscript(index: Int) -> T {
        get {
            precondition(index >= 0 && index < length)
            
            return storage[index]
        }
        set {
            precondition(index >= 0 && index < length)
            
            if !isKnownUniquelyReferenced(&storage) {
                storage = Storage(copying: storage)
            }
            
            storage[index] = newValue
        }
    }
    
}

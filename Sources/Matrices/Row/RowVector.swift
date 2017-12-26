//
//  RowVector.swift
//  Matrices
//
//  Created by Andrea Tomarelli on 14/12/17.
//

public struct RowVector<T: Numeric>: RowVectorType {
    
    private var storage:    Storage<T>

    public let length:      Int

    
    init(storage: Storage<T>) {
        self.storage    = storage
        self.length     = storage.count
    }
    
}

public extension RowVector {
    
    init<V: RowVectorType>(_ other: V) where V.T == T {
        let storage = Storage<T>(size: other.length)
        
        for i in 0 ..< other.length { storage[i] = other[i] }
        
        self.init(storage: storage)
    }
    
    init(length: Int) {
        self.init(storage: Storage(size: length))
    }
    
    init(elements: [T]) {
        self.init(storage: Storage(elements: elements))
    }
    
    init(_ elements: T...) {
        self.init(elements: elements)
    }

}

public extension RowVector {

    var ᵀ: ColumnVector<T> {
        return ColumnVector(storage: storage)
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
            
            if !isKnownUniquelyReferenced(&storage) {
                storage = Storage(copying: storage)
            }
            
            storage[index] = newValue
        }
    }
    
}

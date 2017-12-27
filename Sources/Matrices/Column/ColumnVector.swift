//
//  ColumnVector.swift
//  Matrices
//
//  Created by Andrea Tomarelli on 26/12/17.
//

public struct ColumnVector<T: Numeric> {
    
    private var storage: Storage<T>
    
    
    public var length: Int { return storage.count }
    
    
    init(storage: Storage<T>) {
        self.storage = storage
    }

}

public extension ColumnVector {
    
    static func zeros(length: Int) -> ColumnVector<T> {
        let storage = Storage<T>(size: length)
        for i in 0 ..< length { storage[i] = 0 }
        
        return ColumnVector<T>(storage: storage)
    }
    
    
    var ᵀ: RowVector<T> { return RowVector(storage: storage) }
    
    
    init() {
        self.init(storage: Storage(size: 0))
    }
    
    init(length: Int) {
        self.init(storage: Storage(size: length))
    }
    
    init(elements: [T]) {
        self.init(storage: Storage(elements: elements))
    }

}

extension ColumnVector {
    
    mutating func add(_ other: ColumnVector<T>) {
        precondition(other.length == length)

        if !isKnownUniquelyReferenced(&storage) {
            storage = Storage(copying: storage)
        }
        
        for i in 0 ..< storage.count { storage[i] += other.storage[i] }
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

//
//  RowVector.swift
//  Matrices
//
//  Created by Andrea Tomarelli on 26/12/17.
//

public struct RowVector<T: Numeric> {
    
    private var storage: Storage<T>
    
    
    public var length: Int { return storage.count }
    
    
    init(storage: Storage<T>) {
        self.storage = storage
    }

}

public extension RowVector {
    
    static func zeros(length: Int) -> RowVector<T> {
        let storage = Storage<T>(size: length)
        for i in 0 ..< length { storage[i] = 0 }
        
        return RowVector<T>(storage: storage)
    }
    
    
    var ᵀ: ColumnVector<T> { return ColumnVector(storage: storage) }
    
    
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

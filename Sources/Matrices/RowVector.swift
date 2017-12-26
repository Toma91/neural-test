//
//  RowVector.swift
//  Matrices
//
//  Created by Andrea Tomarelli on 14/12/17.
//

public struct RowVector<T: Numeric> {
 
    private var storage:    Storage<T>

    public let length:      Int
    
 
    init(storage: Storage<T>) {
        self.storage    = storage
        self.length     = storage.count
    }
    
}

public extension RowVector {

    public init(length: Int) {
        self.init(storage: Storage(size: length))
    }
    
    public init(elements: [T]) {
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
    
    func map<U>(_ transform: (T) throws -> U) rethrows -> RowVector<U> {
        var result = RowVector<U>(length: length)
        for i in 0 ..< length { result[i] = try transform(self[i]) }
        return result
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

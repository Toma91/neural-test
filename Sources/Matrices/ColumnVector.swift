//
//  ColumnVector.swift
//  Matrices
//
//  Created by Andrea Tomarelli on 12/12/17.
//

public struct ColumnVector<T: Numeric> {
    
    private var storage:    Storage<T>
    
    private var offset:     Int
    
    private var step:       Int
    
    public let length:      Int
    
   
    init(storage: Storage<T>, offset: Int, step: Int, length: Int) {
        precondition(offset >= 0 && offset < storage.count)
        precondition(step > 0)
        precondition(length > 0 && offset + length <= storage.count)

        self.storage    = storage
        self.offset     = offset
        self.step       = step
        self.length     = length
    }
    
}

public extension ColumnVector {
    
    init(length: Int) {
        self.init(storage: Storage(size: length), offset: 0, step: 1, length: length)
    }
    
}

public extension ColumnVector {
    
    subscript(index: Int) -> T {
        get {
            precondition(index >= 0 && index < length)
            
            return storage[offset + step * index]
        }
        set {
            assert(index >= 0 && index < length)

            if !isKnownUniquelyReferenced(&storage) {
                storage = Storage(copying: storage, from: offset, count: length)
                offset = 0
            }
            
            storage[offset + step * index] = newValue
        }
    }
    
}

//
//  RowVector.swift
//  Matrices
//
//  Created by Andrea Tomarelli on 12/12/17.
//

public struct RowVector<T: Numeric> {
    
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

extension RowVector {

    func assign(from multiplication: RowMultiplication<T>) {
        for index in 0 ..< length {
            storage[offset + step * index] = multiplication[index]
        }
    }
    
}

public extension RowVector {
    
    init(length: Int) {
        self.init(storage: Storage(size: length), offset: 0, step: 1, length: length)
    }
    
}

public extension RowVector {
    
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

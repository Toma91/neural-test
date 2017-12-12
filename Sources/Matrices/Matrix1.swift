//
//  Matrix1.swift
//  Matrices
//
//  Created by Andrea Tomarelli on 12/12/17.
//

import Foundation

public struct Vector<T> {
    
    private let storage:    MatrixStorage<T>
    
    private let offset:     Int
    
    public let length:      Int
    
    
    public init(length: Int) {
        self.storage    = MatrixStorage(size: length)
        self.offset     = 0
        self.length     = length
    }
    
    init(storage: MatrixStorage<T>, offset: Int, length: Int) {
        self.storage    = storage
        self.offset     = offset
        self.length     = length
    }
    
}

public extension Vector {
    
    subscript(index: Int) -> T {
        get {
            precondition(index >= 0 && index < length)
            
            return storage[offset + index]
        }
    }
    
}

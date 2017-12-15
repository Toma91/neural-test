//
//  RowMap.swift
//  Matrices
//
//  Created by Andrea Tomarelli on 15/12/17.
//

public struct RowMap<T: Numeric>: RowVectorType {
    
    private let operation:  (Int) -> T
    
    public let length:      Int
    
    
    init<V: RowVectorType>(vector: V, operation: @escaping (V.T) -> T) {
        self.operation = { operation(vector[$0]) }
        self.length = vector.length
    }
    
}

public extension RowMap {
    
    subscript(index: Int) -> T {
        get {
            precondition(index >= 0 && index < length)
            
            return operation(index)
        }
    }
    
}

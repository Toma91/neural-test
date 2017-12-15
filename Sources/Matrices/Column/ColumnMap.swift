//
//  ColumnMap.swift
//  Matrices
//
//  Created by Andrea Tomarelli on 15/12/17.
//

public struct ColumnMap<T: Numeric>: ColumnVectorType {
    
    private let operation:  (Int) -> T
    
    public let length:      Int
    
    
    public init<V: ColumnVectorType>(vector: V, operation: @escaping (V.T) -> T) {
        self.operation = { operation(vector[$0]) }
        self.length = vector.length
    }
    
}

public extension ColumnMap {
    
    subscript(index: Int) -> T {
        get {
            precondition(index >= 0 && index < length)
            
            return operation(index)
        }
    }
    
}

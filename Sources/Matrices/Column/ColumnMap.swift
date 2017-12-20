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
        self.operation  = { operation(vector[$0]) }
        self.length     = vector.length
    }
    
    init<V1: ColumnVectorType, V2: ColumnVectorType>(v1: V1, v2: V2, operation: @escaping (V1.T, V2.T) -> T) {
        precondition(v1.length == v2.length)
        
        self.operation  = { operation(v1[$0], v2[$0]) }
        self.length     = v1.length
    }
    
    init<V: ColumnVectorType>(multiplying matrix: Matrix<T>, by vector: V) where V.T == T {        
        self.operation  = { matrix.multiply(row: $0, by: vector) }
        self.length     = matrix.nRows
    }
    
}

public extension ColumnMap {
    
    subscript(index: Int) -> T {
        get { return operation(index) }
    }
    
}

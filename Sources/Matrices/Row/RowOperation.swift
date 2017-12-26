//
//  RowOperation.swift
//  Matrices
//
//  Created by Andrea Tomarelli on 26/12/17.
//

public struct RowOperation<T: Numeric>: RowVectorType {
    
    private let accessor:   (Int) -> T

    public let length:      Int
    
    
    public init<V: RowVectorType>(vector: V, operation: @escaping (T) -> T) where V.T == T {
        self.accessor   = { operation(vector[$0]) }
        self.length     = vector.length
    }
    
    init<V1: RowVectorType, V2: RowVectorType>(v1: V1, v2: V2, operation: @escaping (T, T) -> T) where V1.T == T, V2.T == T {
        precondition(v1.length == v2.length)
        
        self.accessor   = { operation(v1[$0], v2[$0]) }
        self.length     = v1.length
    }
 
    init<V: RowVectorType>(multiplying vector: V, by matrix: Matrix<T>) where V.T == T {
        precondition(vector.length == matrix.nRows)
        
        self.accessor   = { vector • matrix[column: $0] }
        self.length     = matrix.nColumns

    }
    
}

public extension RowOperation {
  
    subscript(index: Int) -> T {
        get { return accessor(index) }
    }
    
}

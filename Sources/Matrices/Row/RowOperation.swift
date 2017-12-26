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
 
    init<V: RowVectorType, M: MatrixType>(multiplying vector: V, by matrix: M) where V.T == T, M.T == T {
        precondition(vector.length == matrix.nRows)
        
        self.accessor   = { vector • matrix[column: $0] }
        self.length     = matrix.nColumns

    }
    
    init<V: ColumnVectorType>(transposing vector: V) where V.T == T {
        self.accessor   = { vector[$0] }
        self.length     = vector.length
    }
    
}

public extension RowOperation {
  
    subscript(index: Int) -> T {
        get { return accessor(index) }
    }
    
}

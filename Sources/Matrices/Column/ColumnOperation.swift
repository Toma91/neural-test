//
//  ColumnOperation.swift
//  Matrices
//
//  Created by Andrea Tomarelli on 26/12/17.
//

public struct ColumnOperation<T: Numeric>: ColumnVectorType {
    
    private let accessor:   (Int) -> T

    public let length:      Int
    
    
    public init<V: ColumnVectorType>(vector: V, operation: @escaping (T) -> T) where V.T == T {
        self.accessor   = { operation(vector[$0]) }
        self.length     = vector.length
    }
    
    init<V1: ColumnVectorType, V2: ColumnVectorType>(v1: V1, v2: V2, operation: @escaping (T, T) -> T) where V1.T == T, V2.T == T {
        precondition(v1.length == v2.length)
        
        self.accessor   = { operation(v1[$0], v2[$0]) }
        self.length     = v1.length
    }
 
    init<M: MatrixType, V: ColumnVectorType>(multiplying matrix: M, by vector: V) where M.T == T, V.T == T {
        precondition(matrix.nColumns == vector.length)
        
        self.accessor   = { matrix[row: $0] • vector }
        self.length     = matrix.nRows

    }
    
    init<V: RowVectorType>(transposing vector: V) where V.T == T {
        self.accessor   = { vector[$0] }
        self.length     = vector.length
    }
    
}

public extension ColumnOperation {
  
    subscript(index: Int) -> T {
        get { return accessor(index) }
    }
    
}

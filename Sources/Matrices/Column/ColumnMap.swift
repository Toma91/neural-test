//
//  ColumnMap.swift
//  Matrices
//
//  Created by Andrea Tomarelli on 15/12/17.
//

public struct ColumnMap<T: Numeric>: ColumnVectorType {
    
    private let elementAccessor:    (Int) -> T
    
    public let length:              Int
    
    
    public init<V: ColumnVectorType>(vector: V, operation: @escaping (V.T) -> T) {
        self.elementAccessor    = { operation(vector[$0]) }
        self.length             = vector.length
    }
    
    init<V1: ColumnVectorType, V2: ColumnVectorType>(v1: V1, v2: V2, operation: @escaping (V1.T, V2.T) -> T) {
        precondition(v1.length == v2.length)
        
        self.elementAccessor    = { operation(v1[$0], v2[$0]) }
        self.length             = v1.length
    }
    
    init<M: MatrixType, V: ColumnVectorType>(multiplying matrix: M, by vector: V) where M.T == T, V.T == T {
        self.elementAccessor    = { matrix[row: $0] * vector }
        self.length             = matrix.nRows
    }
    
}

public extension ColumnMap {
    
    subscript(index: Int) -> T {
        get { return elementAccessor(index) }
    }
    
}

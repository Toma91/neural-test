//
//  RowMap.swift
//  Matrices
//
//  Created by Andrea Tomarelli on 15/12/17.
//

public struct RowMap<T: Numeric>: RowVectorType {
    
    private let elementAccessor:    (Int) -> T
    
    public let length:              Int
    
    
    public init<V: RowVectorType>(vector: V, operation: @escaping (V.T) -> T) {
        self.elementAccessor    = { operation(vector[$0]) }
        self.length             = vector.length
    }
    
    init<V1: RowVectorType, V2: RowVectorType>(v1: V1, v2: V2, operation: @escaping (V1.T, V2.T) -> T) {
        precondition(v1.length == v2.length)
        
        self.elementAccessor    = { operation(v1[$0], v2[$0]) }
        self.length             = v1.length
    }
    
    init<V: RowVectorType, M: MatrixType>(multiplying vector: V, by matrix: M) where V.T == T, M.T == T {
        self.elementAccessor    = { vector * matrix[column: $0] }
        self.length             = matrix.nRows
    }
    
    
}

public extension RowMap {
    
    subscript(index: Int) -> T {
        get { return elementAccessor(index) }
    }
    
}

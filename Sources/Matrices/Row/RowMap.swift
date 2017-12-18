//
//  RowMap.swift
//  Matrices
//
//  Created by Andrea Tomarelli on 15/12/17.
//

public struct RowMap<T: Numeric>: RowVectorType {
    
    private let operation:  (Int) -> T
    
    public let length:      Int
    
    
    public init<V: RowVectorType>(vector: V, operation: @escaping (V.T) -> T) {
        self.operation  = { operation(vector[$0]) }
        self.length     = vector.length
    }
    
    init<V1: RowVectorType, V2: RowVectorType>(v1: V1, v2: V2, operation: @escaping (V1.T, V2.T) -> T) {
        precondition(v1.length == v2.length)
        
        self.operation  = { operation(v1[$0], v2[$0]) }
        self.length     = v1.length
    }

    init<V: RowVectorType>(multiplying vector: V, by matrix: Matrix<T>) where V.T == T {
        precondition(vector.length == matrix.nRows)
        
        self.operation  = { c in
            (0 ..< matrix.nRows).reduce(0) { $0 + vector[$1] * matrix[row: $1, column: c] }
        }
        self.length     = matrix.nColumns
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
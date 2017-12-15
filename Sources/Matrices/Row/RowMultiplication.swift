//
//  RowMultiplication.swift
//  learnPackageDescription
//
//  Created by Andrea Tomarelli on 15/12/17.
//

public struct RowMultiplication<T: Numeric>: RowVectorType {
    
    private let lhs:    (Int) -> T

    private let rhs:    Matrix<T>
  
    public let length:  Int
    
    
    init<V: RowVectorType>(lhs: V, rhs: Matrix<T>) where V.T == T {
        precondition(lhs.length == rhs.nRows)
        
        self.lhs    = { lhs[$0] }
        self.rhs    = rhs
        self.length = rhs.nColumns
    }
    
}

public extension RowMultiplication {
    
    subscript(index: Int) -> T {
        get {
            precondition(index >= 0 && index < length)
            
            return (0 ..< rhs.nRows).reduce(0) {
                $0 + lhs($1) * rhs[row: $1, column: index]
            }
        }
    }
    
}

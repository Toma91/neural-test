//
//  ColumnMultiplication.swift
//  learnPackageDescription
//
//  Created by Andrea Tomarelli on 15/12/17.
//

public struct ColumnMultiplication<T: Numeric>: ColumnVectorType {
    
    private let lhs:    Matrix<T>

    private let rhs:    (Int) -> T
  
    public let length:  Int
    
    
    init<V: ColumnVectorType>(lhs: Matrix<T>, rhs: V) where V.T == T {
        precondition(lhs.nColumns == rhs.length)
        
        self.lhs    = lhs
        self.rhs    = { rhs[$0] }
        self.length = lhs.nRows
    }
    
}

public extension ColumnMultiplication {
    
    subscript(index: Int) -> T {
        get {
            precondition(index >= 0 && index < length)
            
            return (0 ..< lhs.nColumns).reduce(0) {
                $0 + lhs[row: index, column: $1] * rhs($1)
            }
        }
    }
    
}

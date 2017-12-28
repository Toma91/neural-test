//
//  Subtractions.swift
//  Matrices
//
//  Created by Andrea Tomarelli on 27/12/17.
//

public func -<T>(lhs: ColumnVector<T>, rhs: ColumnVector<T>) -> ColumnOperation2<T> {
    return ColumnOperation2(lhs: lhs, rhs: rhs, operation: -)
}

public func -=<T>(lhs: inout Matrix<T>, rhs: MatrixOperation1<T>) {
    precondition(lhs.nRows == rhs.nRows && lhs.nColumns == rhs.nColumns)
    
    for r in 0 ..< lhs.nRows {
        for c in 0 ..< lhs.nColumns {
            lhs[row: r, column: c] -= rhs[row: r, column: c]
        }
    }    
}

public func -=<T>(lhs: inout ColumnVector<T>, rhs: ColumnOperation1<T>) {
    precondition(lhs.length == rhs.length)
    
    for i in 0 ..< lhs.length { lhs[i] -= rhs[i] }
}

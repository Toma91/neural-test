//
//  Additions.swift
//  Matrices
//
//  Created by Andrea Tomarelli on 26/12/17.
//

public func +<T>(lhs: MatrixDotColumnOperation<T>, rhs: ColumnVector<T>) -> ColumnOperation2<T> {
    return ColumnOperation2(lhs: lhs, rhs: rhs, operation: +)
}

public func +=<T>(lhs: inout Matrix<T>, rhs: Matrix<T>) {
    precondition(lhs.nRows == rhs.nRows && lhs.nColumns == rhs.nColumns)
    
    for r in 0 ..< lhs.nRows {
        for c in 0 ..< lhs.nColumns {
            lhs[row: r, column: c] += rhs[row: r, column: c]
        }
    }    
}

public func +=<T>(lhs: inout ColumnVector<T>, rhs: ColumnVector<T>) {
    precondition(lhs.length == rhs.length)
    
    for i in 0 ..< lhs.length { lhs[i] += rhs[i] }
}

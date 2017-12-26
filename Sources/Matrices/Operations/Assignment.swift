//
//  Assignment.swift
//  Matrices
//
//  Created by Andrea Tomarelli on 26/12/17.
//

infix operator <~: AssignmentPrecedence

public func <~<V: ColumnVectorType>(lhs: inout ColumnVector<V.T>, rhs: V) {
    if lhs.length == rhs.length {
        for i in 0 ..< lhs.length { lhs[i] = rhs[i] }
    } else {
        lhs = ColumnVector(rhs)
    }
}

public func <~<V: RowVectorType>(lhs: inout RowVector<V.T>, rhs: V) {
    if lhs.length == rhs.length {
        for i in 0 ..< lhs.length { lhs[i] = rhs[i] }
    } else {
        lhs = RowVector(rhs)
    }
}

public func <~<M: MatrixType>(lhs: inout Matrix<M.T>, rhs: M) {
    if lhs.nRows == rhs.nRows && lhs.nColumns == rhs.nColumns {
        for r in 0 ..< lhs.nRows {
            for c in 0 ..< lhs.nColumns {
                lhs[row: r, column: c] = rhs[row: r, column: c]
            }
        }
    } else {
        lhs = Matrix(rhs)
    }
}

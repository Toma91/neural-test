//
//  Assignment.swift
//  Matrices
//
//  Created by Andrea Tomarelli on 26/12/17.
//

infix operator <~: AssignmentPrecedence

public func <~<T>(lhs: inout ColumnVector<T>, rhs: ColumnOperation1<T>) {
    if lhs.length != rhs.length {
        lhs = ColumnVector(length: rhs.length)
    }
    
    for i in 0 ..< rhs.length { lhs[i] = rhs[i] }
}

public func <~<T>(lhs: inout ColumnVector<T>, rhs: ColumnOperation2<T>) {
    if lhs.length != rhs.length {
        lhs = ColumnVector(length: rhs.length)
    }
    
    for i in 0 ..< rhs.length { lhs[i] = rhs[i] }
}

public func <~<T>(lhs: inout Matrix<T>, rhs: ColumnDotRowOperation<T>) {
    if lhs.nRows != rhs.nRows || lhs.nColumns != rhs.nColumns {
        lhs = Matrix(nRows: rhs.nRows, nColumns: rhs.nColumns)
    }
    
    for r in 0 ..< lhs.nRows {
        for c in 0 ..< lhs.nColumns {
            lhs[row: r, column: c] = rhs[row: r, column: c]
        }
    }
}

public func <~<T>(lhs: inout ColumnVector<T>, rhs: TransposedMatrixDotColumnOperation<T>) {
    if lhs.length != rhs.length {
        lhs = ColumnVector(length: rhs.length)
    }
    
    for i in 0 ..< rhs.length { lhs[i] = rhs[i] }
}

public func <~<T>(lhs: inout ColumnVector<T>, rhs: ColumnVector<T>) {
    if lhs.length != rhs.length {
        lhs = ColumnVector(length: rhs.length)
    }
    
    for i in 0 ..< rhs.length { lhs[i] = rhs[i] }
}

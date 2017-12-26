//
//  Additions.swift
//  Matrices
//
//  Created by Andrea Tomarelli on 26/12/17.
//

public func +<T>(lhs: ColumnVector<T>, rhs: ColumnVector<T>) -> ColumnVector<T> {
    precondition(lhs.length == rhs.length)
    
    var result = ColumnVector<T>(length: lhs.length)
    for i in 0 ..< result.length { result[i] = lhs[i] + rhs[i] }
    return result
}

public func +<T>(lhs: RowVector<T>, rhs: RowVector<T>) -> RowVector<T> {
    precondition(lhs.length == rhs.length)
    
    var result = RowVector<T>(length: lhs.length)
    for i in 0 ..< result.length { result[i] = lhs[i] + rhs[i] }
    return result
}

public func +<T>(lhs: Matrix<T>, rhs: Matrix<T>) -> Matrix<T> {
    precondition(lhs.nRows == rhs.nRows)
    precondition(lhs.nColumns == rhs.nColumns)

    var result = Matrix<T>(nRows: lhs.nRows, nColumns: lhs.nColumns)

    for r in 0 ..< result.nRows {
        for c in 0 ..< result.nColumns {
            result[row: r, column: c] = lhs[row: r, column: c] + rhs[row: r, column: c]
        }
    }
    
    return result
}

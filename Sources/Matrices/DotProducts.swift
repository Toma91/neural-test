//
//  DotProducts.swift
//  Matrices
//
//  Created by Andrea Tomarelli on 26/12/17.
//

infix operator •: MultiplicationPrecedence

public func •<T>(lhs: ColumnVector<T>, rhs: RowVector<T>) -> Matrix<T> {
    var result = Matrix<T>(nRows: lhs.length, nColumns: rhs.length)
    
    for r in 0 ..< result.nRows {
        for c in 0 ..< result.nColumns {
            result[row: r, column: c] = lhs[r] * rhs[c]
        }
    }
    
    return result
}

public func •<T>(lhs: RowVector<T>, rhs: ColumnVector<T>) -> T {
    precondition(lhs.length == rhs.length)
    
    return (0 ..< lhs.length).reduce(0) { $0 + lhs[$1] * rhs[$1] }
}

public func •<T>(lhs: RowVector<T>, rhs: Matrix<T>) -> RowVector<T> {
    precondition(lhs.length == rhs.nRows)
    
    var result = RowVector<T>(length: rhs.nColumns)
    
    for i in 0 ..< result.length {
        result[i] = lhs • rhs[column: i]
    }
    
    return result
}

public func •<T>(lhs: Matrix<T>, rhs: ColumnVector<T>) -> ColumnVector<T> {
    precondition(lhs.nColumns == rhs.length)
    
    var result = ColumnVector<T>(length: lhs.nRows)
    
    for i in 0 ..< result.length {
        result[i] = lhs[row: i] • rhs
    }
    
    return result
}

public func •<T>(lhs: Matrix<T>, rhs: Matrix<T>) -> Matrix<T> {
    precondition(lhs.nColumns == rhs.nRows)

    var result = Matrix<T>(nRows: lhs.nRows, nColumns: rhs.nColumns)
    
    for r in 0 ..< result.nRows {
        for c in 0 ..< result.nColumns {
            result[row: r, column: c] = lhs[row: r] • rhs[column: c]
        }
    }
    
    return result
}

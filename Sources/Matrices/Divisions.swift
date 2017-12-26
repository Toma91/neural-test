//
//  Divisions.swift
//  Matrices
//
//  Created by Andrea Tomarelli on 26/12/17.
//

public func /<T: BinaryInteger>(lhs: ColumnVector<T>, rhs: ColumnVector<T>) -> ColumnVector<T> {
    precondition(lhs.length == rhs.length)
    
    var result = ColumnVector<T>(length: lhs.length)
    for i in 0 ..< result.length { result[i] = lhs[i] / rhs[i] }
    return result
}

public func /<T: FloatingPoint>(lhs: ColumnVector<T>, rhs: ColumnVector<T>) -> ColumnVector<T> {
    precondition(lhs.length == rhs.length)
    
    var result = ColumnVector<T>(length: lhs.length)
    for i in 0 ..< result.length { result[i] = lhs[i] / rhs[i] }
    return result
}

public func /<T: BinaryInteger>(lhs: T, rhs: ColumnVector<T>) -> ColumnVector<T> {
    return rhs.map { lhs / $0 }
}

public func /<T: FloatingPoint>(lhs: T, rhs: ColumnVector<T>) -> ColumnVector<T> {
    return rhs.map { lhs / $0 }
}

public func /<T: BinaryInteger>(lhs: ColumnVector<T>, rhs: T) -> ColumnVector<T> {
    return lhs.map { $0 / rhs }
}

public func /<T: FloatingPoint>(lhs: ColumnVector<T>, rhs: T) -> ColumnVector<T> {
    return lhs.map { $0 / rhs }
}

public func /<T: BinaryInteger>(lhs: RowVector<T>, rhs: RowVector<T>) -> RowVector<T> {
    precondition(lhs.length == rhs.length)
    
    var result = RowVector<T>(length: lhs.length)
    for i in 0 ..< result.length { result[i] = lhs[i] / rhs[i] }
    return result
}

public func /<T: FloatingPoint>(lhs: RowVector<T>, rhs: RowVector<T>) -> RowVector<T> {
    precondition(lhs.length == rhs.length)
    
    var result = RowVector<T>(length: lhs.length)
    for i in 0 ..< result.length { result[i] = lhs[i] / rhs[i] }
    return result
}

public func /<T: BinaryInteger>(lhs: T, rhs: RowVector<T>) -> RowVector<T> {
    return rhs.map { lhs / $0 }
}

public func /<T: FloatingPoint>(lhs: T, rhs: RowVector<T>) -> RowVector<T> {
    return rhs.map { lhs / $0 }
}

public func /<T: BinaryInteger>(lhs: RowVector<T>, rhs: T) -> RowVector<T> {
    return lhs.map { $0 / rhs }
}

public func /<T: FloatingPoint>(lhs: RowVector<T>, rhs: T) -> RowVector<T> {
    return lhs.map { $0 / rhs }
}

public func /<T: BinaryInteger>(lhs: Matrix<T>, rhs: Matrix<T>) -> Matrix<T> {
    precondition(lhs.nRows == rhs.nRows)
    precondition(lhs.nColumns == rhs.nColumns)
    
    var result = Matrix<T>(nRows: lhs.nRows, nColumns: lhs.nColumns)
    
    for r in 0 ..< result.nRows {
        for c in 0 ..< result.nColumns {
            result[row: r, column: c] = lhs[row: r, column: c] / rhs[row: r, column: c]
        }
    }
    
    return result
}

public func /<T: FloatingPoint>(lhs: Matrix<T>, rhs: Matrix<T>) -> Matrix<T> {
    precondition(lhs.nRows == rhs.nRows)
    precondition(lhs.nColumns == rhs.nColumns)
    
    var result = Matrix<T>(nRows: lhs.nRows, nColumns: lhs.nColumns)
    
    for r in 0 ..< result.nRows {
        for c in 0 ..< result.nColumns {
            result[row: r, column: c] = lhs[row: r, column: c] / rhs[row: r, column: c]
        }
    }
    
    return result
}

public func /<T: BinaryInteger>(lhs: T, rhs: Matrix<T>) -> Matrix<T> {
    return rhs.map { lhs / $0 }
}

public func /<T: FloatingPoint>(lhs: T, rhs: Matrix<T>) -> Matrix<T> {
    return rhs.map { lhs / $0 }
}

public func /<T: BinaryInteger>(lhs: Matrix<T>, rhs: T) -> Matrix<T> {
    return lhs.map { $0 / rhs }
}

public func /<T: FloatingPoint>(lhs: Matrix<T>, rhs: T) -> Matrix<T> {
    return lhs.map { $0 / rhs }
}

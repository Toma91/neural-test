//
//  DotProducts.swift
//  Matrices
//
//  Created by Andrea Tomarelli on 26/12/17.
//

infix operator •: MultiplicationPrecedence

public func •<T, C: ColumnVectorType, R: RowVectorType>(lhs: C, rhs: R) -> MatrixOperation<T> where C.T == T, R.T == T {
    return MatrixOperation(multiplying: lhs, by: rhs)
}

public func •<T, R: RowVectorType, C: ColumnVectorType>(lhs: R, rhs: C) -> T where R.T == T, C.T == T {
    precondition(lhs.length == rhs.length)
    
    var result: T = 0
    
    for i in 0 ..< lhs.length { result += lhs[i] * rhs[i] }
    
    return result
}

public func •<T, M: MatrixType, V: ColumnVectorType>(lhs: M, rhs: V) -> ColumnOperation<T> where M.T == T, V.T == T {
    return ColumnOperation(multiplying: lhs, by: rhs)
}

public func •<T, V: RowVectorType, M: MatrixType>(lhs: V, rhs: M) -> RowOperation<T> where M.T == T, V.T == T {
    return RowOperation(multiplying: lhs, by: rhs)
}
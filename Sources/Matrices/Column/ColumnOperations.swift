//
//  ColumnOperations.swift
//  Matrices
//
//  Created by Andrea Tomarelli on 13/12/17.
//

public func <~<V: ColumnVectorType, T>(lhs: inout ColumnVector<T>, rhs: V) where V.T == T {
    precondition(lhs.length == rhs.length)
    
    for i in 0 ..< lhs.length {
        lhs[i] = rhs[i]
    }
}

public func *<V: ColumnVectorType, T>(lhs: Matrix<T>, rhs: V) -> ColumnMultiplication<T> where V.T == T {
    return ColumnMultiplication(lhs: lhs, rhs: rhs)
}

public func +<V1: ColumnVectorType, V2: ColumnVectorType, T>(lhs: V1, rhs: V2) -> ColumnAddition<T> where V1.T == T, V2.T == T {
    return ColumnAddition(lhs: lhs, rhs: rhs)
}

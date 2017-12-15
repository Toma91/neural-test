//
//  RowOperations.swift
//  Matrices
//
//  Created by Andrea Tomarelli on 13/12/17.
//

public func <~<V: RowVectorType, T>(lhs: inout RowVector<T>, rhs: V) where V.T == T {
    fatalError()
}

public func *<V: RowVectorType, T>(lhs: V, rhs: Matrix<T>) -> RowMultiplication<T> where V.T == T {
    return RowMultiplication(lhs: lhs, rhs: rhs)
}

public func +<V1: RowVectorType, V2: RowVectorType, T>(lhs: V1, rhs: V2) -> RowMultiplication<T> where V1.T == T, V2.T == T {
    fatalError()
}

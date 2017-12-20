//
//  Operations.swift
//  Matrices
//
//  Created by Andrea Tomarelli on 15/12/17.
//

public func *<V1: ColumnVectorType, V2: RowVectorType, T>(lhs: V1, rhs: V2) -> MultiplicationMatrix<T> where V1.T == T, V2.T == T {
    return MultiplicationMatrix(multiplying: lhs, by: rhs)
}

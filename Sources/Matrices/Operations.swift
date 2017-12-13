//
//  Operations.swift
//  Matrices
//
//  Created by Andrea Tomarelli on 13/12/17.
//

public func *<T>(lhs: RowVector<T>, rhs: Matrix<T>) -> RowVectorExpression<T> {
    return RowVectorExpression(vector: lhs, matrix: rhs)
}

public func *<T>(lhs: Matrix<T>, rhs: ColumnVector<T>) -> ColumnVectorExpression<T> {
    return ColumnVectorExpression(matrix: lhs, vector: rhs)
}

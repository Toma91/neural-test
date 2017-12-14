//
//  Operations.swift
//  Matrices
//
//  Created by Andrea Tomarelli on 13/12/17.
//

public func *<T>(lhs: Matrix<T>, rhs: ColumnVector<T>) -> MatrixSliceColumn<T> {
    return MatrixSliceColumn(matrix: lhs, multiplying: rhs)
}

public func *<T>(lhs: RowVector<T>, rhs: Matrix<T>) -> MatrixSliceRow<T> {
    return MatrixSliceRow(vector: lhs, multiplying: rhs)
}

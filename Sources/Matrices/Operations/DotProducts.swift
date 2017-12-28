//
//  DotProducts.swift
//  Matrices
//
//  Created by Andrea Tomarelli on 26/12/17.
//

infix operator •: MultiplicationPrecedence

public func •<T>(lhs: Matrix<T>, rhs: ColumnVector<T>) -> MatrixDotColumnOperation<T> {
    return MatrixDotColumnOperation(lhs: lhs, rhs: rhs)
}

public func •<T>(lhs: ColumnVector<T>, rhs: RowVector<T>) -> ColumnDotRowOperation<T> {
    return ColumnDotRowOperation(lhs: lhs, rhs: rhs)
}

public func •<T>(lhs: TransposedMatrix<T>, rhs: ColumnVector<T>) -> TransposedMatrixDotColumnOperation<T> {
    return TransposedMatrixDotColumnOperation(lhs: lhs, rhs: rhs)
}


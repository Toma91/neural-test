//
//  DotProducts.swift
//  Matrices
//
//  Created by Andrea Tomarelli on 26/12/17.
//

public struct MatrixDotColumnOperation<T: Numeric> {
    
}

public struct ColumnDotRowOperation<T: Numeric> {
    
}

infix operator •: MultiplicationPrecedence

public func •<T>(lhs: Matrix<T>, rhs: ColumnVector<T>) -> MatrixDotColumnOperation<T> {
    fatalError()
}

public func •<T>(lhs: ColumnVector<T>, rhs: RowVector<T>) -> ColumnDotRowOperation<T> {
    fatalError()
}

public func •<T>(lhs: TransposedMatrix<T>, rhs: ColumnVector<T>) -> MatrixDotColumnOperation<T> {
    fatalError()
}

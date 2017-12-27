//
//  Divisions.swift
//  Matrices
//
//  Created by Andrea Tomarelli on 26/12/17.
//

public func /<T: FloatingPoint>(lhs: Matrix<T>, rhs: T) -> MatrixOperation1<T> {
    return MatrixOperation1(lhs: lhs, rhs: rhs, operation: /)
}

public func /<T: FloatingPoint>(lhs: ColumnVector<T>, rhs: T) -> ColumnOperation1<T> {
    return ColumnOperation1(lhs: lhs, rhs: rhs, operation: /)
}

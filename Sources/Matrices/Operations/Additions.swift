//
//  Additions.swift
//  Matrices
//
//  Created by Andrea Tomarelli on 26/12/17.
//

public func +<T>(lhs: MatrixDotColumnOperation<T>, rhs: ColumnVector<T>) -> ColumnOperation2<T> {
    return ColumnOperation2(lhs: lhs, rhs: rhs, operation: +)
}

public func +=<T>(lhs: inout Matrix<T>, rhs: Matrix<T>) {
    lhs.add(rhs)
}

public func +=<T>(lhs: inout ColumnVector<T>, rhs: ColumnVector<T>) {
    lhs.add(rhs)
}

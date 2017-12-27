//
//  Subtractions.swift
//  Matrices
//
//  Created by Andrea Tomarelli on 27/12/17.
//

public func -<T>(lhs: ColumnVector<T>, rhs: ColumnVector<T>) -> ColumnOperation2<T> {
    return ColumnOperation2(lhs: lhs, rhs: rhs, operation: -)
}

public func -=<T>(lhs: inout Matrix<T>, rhs: MatrixOperation1<T>) {
    rhs.execute(into: &lhs)
}

public func -=<T>(lhs: inout ColumnVector<T>, rhs: ColumnOperation1<T>) {
    rhs.execute(into: &lhs)
}

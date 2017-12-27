//
//  Assignment.swift
//  Matrices
//
//  Created by Andrea Tomarelli on 26/12/17.
//

infix operator <~: AssignmentPrecedence

public func <~<T>(lhs: inout ColumnVector<T>, rhs: ColumnOperation1<T>) {
    fatalError()
}

public func <~<T>(lhs: inout ColumnVector<T>, rhs: ColumnOperation2<T>) {
    fatalError()
}

public func <~<T>(lhs: inout Matrix<T>, rhs: ColumnDotRowOperation<T>) {
    fatalError()
}

public func <~<T>(lhs: inout ColumnVector<T>, rhs: MatrixDotColumnOperation<T>) {
    fatalError()
}

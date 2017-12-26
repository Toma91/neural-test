//
//  Assignment.swift
//  Matrices
//
//  Created by Andrea Tomarelli on 26/12/17.
//

infix operator <~: AssignmentPrecedence

public func <~<T>(lhs: inout ColumnVector<T>, rhs: ColumnOperation1<T>) {
    rhs.assign(to: &lhs)
}

public func <~<T>(lhs: inout ColumnVector<T>, rhs: ColumnOperation2<T>) {
    rhs.assign(to: &lhs)
}

public func <~<T>(lhs: inout Matrix<T>, rhs: ColumnRowOperation<T>) {
    fatalError()
}

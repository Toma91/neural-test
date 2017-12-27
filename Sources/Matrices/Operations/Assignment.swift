//
//  Assignment.swift
//  Matrices
//
//  Created by Andrea Tomarelli on 26/12/17.
//

infix operator <~: AssignmentPrecedence


public func <~<T>(lhs: inout ColumnVector<T>, rhs: ColumnOperation1<T>) {
    rhs.execute(into: &lhs)
}

public func <~<T>(lhs: inout ColumnVector<T>, rhs: ColumnOperation2<T>) {
    rhs.execute(into: &lhs)
}

public func <~<T>(lhs: inout Matrix<T>, rhs: ColumnDotRowOperation<T>) {
    rhs.execute(into: &lhs)
}

public func <~<T>(lhs: inout ColumnVector<T>, rhs: TransposedMatrixDotColumnOperation<T>) {
    rhs.execute(into: &lhs)
}

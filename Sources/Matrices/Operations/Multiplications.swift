//
//  Multiplications.swift
//  Matrices
//
//  Created by Andrea Tomarelli on 27/12/17.
//

public func *<T>(lhs: T, rhs: ColumnOperation2<T>) -> ColumnOperation1<T> {
    return ColumnOperation1(lhs: lhs, rhs: rhs, operation: *)
}

public func *<T>(lhs: ColumnOperation1<T>, rhs: ColumnVector<T>) -> ColumnOperation2<T> {
    return ColumnOperation2(lhs: lhs, rhs: rhs, operation: *)
}

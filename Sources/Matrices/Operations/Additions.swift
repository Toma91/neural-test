//
//  Additions.swift
//  Matrices
//
//  Created by Andrea Tomarelli on 26/12/17.
//

public func +<T>(lhs: MatrixColumnDot<T>, rhs: ColumnVector<T>) -> ColumnOperation2<T> {
    return ColumnOperation2(v1: lhs, v2: rhs, operation: +)
}

//
//  Additions.swift
//  Matrices
//
//  Created by Andrea Tomarelli on 26/12/17.
//

public func +<T, V1: ColumnVectorType, V2: ColumnVectorType>(lhs: V1, rhs: V2) -> ColumnOperation<T> where V1.T == T, V2.T == T {
    return ColumnOperation(v1: lhs, v2: rhs, operation: +)
}

public func +<T, V1: RowVectorType, V2: RowVectorType>(lhs: V1, rhs: V2) -> RowOperation<T> where V1.T == T, V2.T == T {
    return RowOperation(v1: lhs, v2: rhs, operation: +)
}

public func +<T, M1: MatrixType, M2: MatrixType>(lhs: M1, rhs: M2) -> MatrixOperation<T> where M1.T == T, M2.T == T {
    return MatrixOperation(m1: lhs, m2: rhs, operation: +)
}

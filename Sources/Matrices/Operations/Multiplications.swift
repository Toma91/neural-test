//
//  Multiplications.swift
//  Matrices
//
//  Created by Andrea Tomarelli on 26/12/17.
//

public func *<T, V1: ColumnVectorType, V2: ColumnVectorType>(lhs: V1, rhs: V2) -> ColumnOperation<T> where V1.T == T, V2.T == T {
    return ColumnOperation(v1: lhs, v2: rhs, operation: *)
}

public func *<T, V1: RowVectorType, V2: RowVectorType>(lhs: V1, rhs: V2) -> RowOperation<T> where V1.T == T, V2.T == T {
    return RowOperation(v1: lhs, v2: rhs, operation: *)
}

public func *<V: ColumnVectorType>(lhs: V, rhs: V.T) -> ColumnOperation<V.T> {
    return ColumnOperation(vector: lhs, operation: { $0 * rhs })
}

public func *<V: RowVectorType>(lhs: V, rhs: V.T) -> RowOperation<V.T> {
    return RowOperation(vector: lhs, operation: { $0 * rhs })
}

public func *<V: ColumnVectorType>(lhs: V.T, rhs: V) -> ColumnOperation<V.T> {
    return ColumnOperation(vector: rhs, operation: { lhs * $0 })
}

public func *<V: RowVectorType>(lhs: V.T, rhs: V) -> RowOperation<V.T> {
    return RowOperation(vector: rhs, operation: { lhs * $0 })
}

public func *<M: MatrixType>(lhs: M, rhs: M.T) -> MatrixOperation<M.T> {
    return MatrixOperation(matrix: lhs, operation: { $0 * rhs })
}

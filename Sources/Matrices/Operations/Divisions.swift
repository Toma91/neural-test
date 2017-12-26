//
//  Divisions.swift
//  Matrices
//
//  Created by Andrea Tomarelli on 26/12/17.
//

public func /<V: ColumnVectorType>(lhs: V, rhs: V.T) -> ColumnOperation<V.T> where V.T: FloatingPoint {
    return ColumnOperation(vector: lhs, operation: { $0 / rhs })
}

public func /<V: RowVectorType>(lhs: V, rhs: V.T) -> RowOperation<V.T> where V.T: FloatingPoint {
    return RowOperation(vector: lhs, operation: { $0 / rhs })
}

public func /<M: MatrixType>(lhs: M, rhs: M.T) -> MatrixOperation<M.T> where M.T: FloatingPoint {
    return MatrixOperation(matrix: lhs, operation: { $0 / rhs })
}

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

public func +=<V: ColumnVectorType>(lhs: inout ColumnVector<V.T>, rhs: V) {
    precondition(lhs.length == rhs.length)
    
    for i in 0 ..< lhs.length { lhs[i] += rhs[i] }
}

public func +=<V: RowVectorType>(lhs: inout RowVector<V.T>, rhs: V) {
    precondition(lhs.length == rhs.length)
    
    for i in 0 ..< lhs.length { lhs[i] += rhs[i] }
}

public func +=<M: MatrixType>(lhs: inout Matrix<M.T>, rhs: M) {
    precondition(lhs.nRows == rhs.nRows)
    precondition(lhs.nColumns == rhs.nColumns)

    for r in 0 ..< lhs.nRows {
        for c in 0 ..< lhs.nColumns {
            lhs[row: r, column: c] += rhs[row: r, column: c]
        }
    }
}

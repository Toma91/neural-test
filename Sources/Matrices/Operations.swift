//
//  Operations.swift
//  Matrices
//
//  Created by Andrea Tomarelli on 15/12/17.
//

public func *<V1: RowVectorType, V2: ColumnVectorType, T>(lhs: V1, rhs: V2) -> T where V1.T == T, V2.T == T {
    precondition(lhs.length == rhs.length)
    
    return (0 ..< lhs.length).reduce(0) { $0 + lhs[$1] * rhs[$1] }
}

public func *<V1: ColumnVectorType, V2: RowVectorType, T>(lhs: V1, rhs: V2) -> MultiplicationMatrix<T> where V1.T == T, V2.T == T {
    return MultiplicationMatrix(multiplying: lhs, by: rhs)
}

public func *<M: MatrixType>(lhs: M.T, rhs: M) -> MatrixMap<M.T> {
    return MatrixMap(matrix: rhs, operation: { lhs * $0 })
}

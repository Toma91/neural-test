//
//  ColumnOperations.swift
//  Matrices
//
//  Created by Andrea Tomarelli on 13/12/17.
//

public func <~<V: ColumnVectorType>(lhs: inout ColumnVector<V.T>, rhs: V) {
    precondition(lhs.length == rhs.length)
    
    for i in 0 ..< lhs.length { lhs[i] = rhs[i] }
}

public func +<V1: ColumnVectorType, V2: ColumnVectorType, T>(lhs: V1, rhs: V2) -> ColumnMap<T> where V1.T == T, V2.T == T {
    return ColumnMap(v1: lhs, v2: rhs, operation: +)
}

public func -<V1: ColumnVectorType, V2: ColumnVectorType, T>(lhs: V1, rhs: V2) -> ColumnMap<T> where V1.T == T, V2.T == T {
    return ColumnMap(v1: lhs, v2: rhs, operation: -)
}

public func *<V: ColumnVectorType>(lhs: V.T, rhs: V) -> ColumnMap<V.T> {
    return ColumnMap(vector: rhs, operation: { lhs * $0 })
}

public func *<V: ColumnVectorType>(lhs: V, rhs: V.T) -> ColumnMap<V.T> {
    return ColumnMap(vector: lhs, operation: { rhs * $0 })
}

public func *<T, M: MatrixType, V: ColumnVectorType>(lhs: M, rhs: V) -> ColumnMap<T> where M.T == T, V.T == T {
    return ColumnMap(multiplying: lhs, by: rhs)
}

//
//  RowOperations.swift
//  Matrices
//
//  Created by Andrea Tomarelli on 13/12/17.
//

public func <~<V: RowVectorType>(lhs: inout RowVector<V.T>, rhs: V) {
    precondition(lhs.length == rhs.length)
    
    for i in 0 ..< lhs.length { lhs[i] = rhs[i] }
}

public func +<V1: RowVectorType, V2: RowVectorType, T>(lhs: V1, rhs: V2) -> RowMap<T> where V1.T == T, V2.T == T {
    return RowMap(v1: lhs, v2: rhs, operation: +)
}

public func -<V1: RowVectorType, V2: RowVectorType, T>(lhs: V1, rhs: V2) -> RowMap<T> where V1.T == T, V2.T == T {
    return RowMap(v1: lhs, v2: rhs, operation: -)
}

public func *<V: RowVectorType>(lhs: V.T, rhs: V) -> RowMap<V.T> {
    return RowMap(vector: rhs, operation: { lhs * $0 })
}

public func *<V: RowVectorType>(lhs: V, rhs: V.T) -> RowMap<V.T> {
    return RowMap(vector: lhs, operation: { rhs * $0 })
}

public func *<T, V: RowVectorType, M: MatrixType>(lhs: V, rhs: M) -> RowMap<T> where M.T == T, V.T == T {
    return RowMap(multiplying: lhs, by: rhs)
}

//
//  RowOperations.swift
//  Matrices
//
//  Created by Andrea Tomarelli on 13/12/17.
//

public func <~<V: RowVectorType, T>(lhs: inout RowVector<T>, rhs: V) where V.T == T {
    fatalError()
}

public func *<V: RowVectorType, T>(lhs: V, rhs: Matrix<T>) -> RowMap<T> where V.T == T {
    return RowMap(multiplying: lhs, by: rhs)    
}

public func +<V1: RowVectorType, V2: RowVectorType, T>(lhs: V1, rhs: V2) -> RowMap<T> where V1.T == T, V2.T == T {
    fatalError()
}

public func -<V1: RowVectorType, V2: RowVectorType, T>(lhs: V1, rhs: V2) -> RowMap<T> where V1.T == T, V2.T == T {
    fatalError()
}

public func *<V: RowVectorType, T>(lhs: T, rhs: V) -> RowMap<T> where V.T == T {
    return RowMap(vector: rhs, operation: { lhs * $0 })
}

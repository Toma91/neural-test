//
//  _Multiplications.swift
//  Matrices
//
//  Created by Andrea Tomarelli on 27/12/17.
//

public struct ColumnOperation1<T: Numeric> {
    
}

public func *<T>(lhs: T, rhs: ColumnOperation2<T>) -> ColumnOperation1<T> {
    fatalError()
}

public func *<T>(lhs: ColumnOperation1<T>, rhs: ColumnVector<T>) -> ColumnOperation2<T> {
    fatalError()
}

//
//  Divisions.swift
//  Matrices
//
//  Created by Andrea Tomarelli on 26/12/17.
//

public struct MatrixOperation1<T: Numeric> {
    
}

public func /<T: FloatingPoint>(lhs: Matrix<T>, rhs: T) -> MatrixOperation1<T> {
    fatalError()
}

public func /<T: FloatingPoint>(lhs: ColumnVector<T>, rhs: T) -> ColumnOperation1<T> {
    fatalError()
}

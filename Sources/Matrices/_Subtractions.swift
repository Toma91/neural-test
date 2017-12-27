//
//  _Subtractions.swift
//  Matrices
//
//  Created by Andrea Tomarelli on 27/12/17.
//

public struct ColumnOperation2<T: Numeric> {
    
}

public func -<T>(lhs: ColumnVector<T>, rhs: ColumnVector<T>) -> ColumnOperation2<T> {
    fatalError()
}

public func -=<T>(lhs: inout Matrix<T>, rhs: MatrixOperation1<T>) {
    fatalError()
}

public func -=<T>(lhs: inout ColumnVector<T>, rhs: ColumnOperation1<T>) {
    fatalError()
}

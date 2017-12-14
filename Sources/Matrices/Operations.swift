//
//  Operations.swift
//  Matrices
//
//  Created by Andrea Tomarelli on 13/12/17.
//

public func *<T>(lhs: Matrix<T>, rhs: ColumnVector<T>) -> MatrixSliceColumn<T> {
    return MatrixSliceColumn(matrix: lhs, multiplying: rhs)
}

public func *<T>(lhs: RowVector<T>, rhs: Matrix<T>) -> MatrixSliceRow<T> {
    return MatrixSliceRow(vector: lhs, multiplying: rhs)
}

func test() {
    var m = Matrix<Int>(nRows: 3, nColumns: 4)

    let a = Matrix<Int>(nRows: 3, nColumns: 4)
    let b = ColumnVector<Int>(length: 4)
    
    m[column: 0] = a * b
}

//
//  DotProducts.swift
//  Matrices
//
//  Created by Andrea Tomarelli on 26/12/17.
//

infix operator •: MultiplicationPrecedence

public func •<T>(lhs: Matrix<T>, rhs: ColumnVector<T>) -> MatrixColumnDot<T> {
    return MatrixColumnDot(matrix: lhs, vector: rhs)
}

public func •<T>(lhs: ColumnVector<T>, rhs: RowVector<T>) -> ColumnRowOperation<T> {
    fatalError()
}

public func •<T>(lhs: TransposedMatrix<T>, rhs: ColumnVector<T>) -> MatrixColumnDot<T> {
    fatalError()
}



/*


public func •<T, R: RowVectorType, C: ColumnVectorType>(lhs: R, rhs: C) -> T where R.T == T, C.T == T {
    precondition(lhs.length == rhs.length)
    
    var result: T = 0
    
    for i in 0 ..< lhs.length { result += lhs[i] * rhs[i] }
    
    return result
}

public func •<T, M: MatrixType, V: ColumnVectorType>(lhs: M, rhs: V) -> ColumnOperation<T> where M.T == T, V.T == T {
    return ColumnOperation(multiplying: lhs, by: rhs)
}

public func •<T, V: RowVectorType, M: MatrixType>(lhs: V, rhs: M) -> RowOperation<T> where M.T == T, V.T == T {
    return RowOperation(multiplying: lhs, by: rhs)
}
*/

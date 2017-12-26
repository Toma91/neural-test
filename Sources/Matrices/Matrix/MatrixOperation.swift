//
//  MatrixOperation.swift
//  Matrices
//
//  Created by Andrea Tomarelli on 26/12/17.
//

public struct MatrixOperation<T: Numeric>: MatrixType {
    
    private let accessor:   (Int, Int) -> T
    
    public let nRows:       Int
    
    public let nColumns:    Int
    
    
    init<M1: MatrixType, M2: MatrixType>(m1: M1, m2: M2, operation: @escaping (T, T) -> T) where M1.T == T, M2.T == T {
        precondition(m1.nRows == m2.nRows)
        precondition(m1.nColumns == m2.nColumns)

        self.accessor   = { operation(m1[row: $0, column: $1], m2[row: $0, column: $1]) }
        self.nRows      = m1.nRows
        self.nColumns   = m1.nColumns
    }
    
    init<C: ColumnVectorType, R: RowVectorType>(multiplying columnVector: C, by rowVector: R) where C.T == T, R.T == T {
        self.accessor   = { columnVector[$0] * rowVector[$1] }
        self.nRows      = columnVector.length
        self.nColumns   = rowVector.length
    }
    
}

public extension MatrixOperation {
    
    subscript(row row: Int, column column: Int) -> T {
        get { return accessor(row, column) }
    }

}

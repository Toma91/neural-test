//
//  TransposedMatrix.swift
//  Matrices
//
//  Created by Andrea Tomarelli on 26/12/17.
//

public struct TransposedMatrix<T: Numeric>: MatrixType {
   
    private let elementAccessor:    (Int, Int) -> T

    private let rowAccessor:        (Int) -> RowOperation<T>

    private let columnAccessor:     (Int) -> ColumnOperation<T>
    
    public let nRows:               Int
    
    public let nColumns:            Int
    
    
    init<M: MatrixType>(transposing matrix: M) where M.T == T {
        self.elementAccessor    = { matrix[row: $1, column: $0] }
        self.rowAccessor        = { RowOperation(transposing: matrix[column: $0]) }
        self.columnAccessor     = { ColumnOperation(transposing: matrix[row: $0]) }
        self.nRows              = matrix.nColumns
        self.nColumns           = matrix.nRows
    }
    
}

public extension TransposedMatrix {

    var ᵀ: TransposedMatrix<T> { return TransposedMatrix(transposing: self) }
    
}

public extension TransposedMatrix {

    subscript(row row: Int, column column: Int) -> T {
        get { return elementAccessor(row, column) }
    }
    
    subscript(row row: Int) -> RowOperation<T> {
        get { return rowAccessor(row) }
    }
    
    subscript(column column: Int) -> ColumnOperation<T> {
        get { return columnAccessor(column) }
    }
    
}

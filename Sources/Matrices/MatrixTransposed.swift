//
//  MatrixTransposed.swift
//  Matrices
//
//  Created by Andrea Tomarelli on 24/12/17.
//

public struct MatrixTransposed<T: Numeric>: MatrixType {
   
    private let elementAccessor:    (Int, Int) -> T

    private let rowAccessor:        (Int) -> RowTransposed<T>

    private let columnAccessor:     (Int) -> ColumnTransposed<T>

    public let nRows:               Int
    
    public let nColumns:            Int
    
    
    init<M: MatrixType>(transposing matrix: M) where M.T == T {
        self.elementAccessor    = { matrix[row: $1, column: $0] }
        self.rowAccessor        = { transpose(matrix[column: $0]) }
        self.columnAccessor     = { transpose(matrix[row: $0]) }
        self.nRows              = matrix.nColumns
        self.nColumns           = matrix.nRows
    }
    
}

public extension MatrixTransposed {

    subscript(row row: Int, column column: Int) -> T {
        get { return elementAccessor(row, column) }
    }

    subscript(row row: Int) -> RowTransposed<T> {
        get { return rowAccessor(row) }
    }
    
    subscript(column column: Int) -> ColumnTransposed<T> {
        get { return columnAccessor(column) }
    }
    
}

public func transpose<M: MatrixType>(_ matrix: M) -> MatrixTransposed<M.T> {
    return MatrixTransposed(transposing: matrix)
}

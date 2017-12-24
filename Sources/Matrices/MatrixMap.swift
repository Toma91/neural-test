//
//  MatrixMap.swift
//  Matrices
//
//  Created by Andrea Tomarelli on 15/12/17.
//

public struct MatrixMap<T: Numeric>: MatrixType {
    
    private let elementAccessor:    (Int, Int) -> T
    
    private let rowAccessor:        (Int) -> RowMap<T>

    private let columnAccessor:     (Int) -> ColumnMap<T>

    public let nRows:               Int
    
    public let nColumns:            Int

    
    public init<M: MatrixType>(matrix: M, operation: @escaping (M.T) -> T) {
        self.elementAccessor    = { operation(matrix[row: $0, column: $1]) }
        self.rowAccessor        = { RowMap(vector: matrix[row: $0], operation: operation) }
        self.columnAccessor     = { ColumnMap(vector: matrix[column: $0], operation: operation) }
        self.nRows              = matrix.nRows
        self.nColumns           = matrix.nColumns
    }
    
}

public extension MatrixMap {
    
    subscript(row row: Int, column column: Int) -> T {
        get { return elementAccessor(row, column) }
    }
    
    subscript(row row: Int) -> RowMap<T> {
        get { return rowAccessor(row) }
    }
    
    subscript(column column: Int) -> ColumnMap<T> {
        get { return columnAccessor(column) }
    }
    
}

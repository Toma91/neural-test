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
    
    init<M1: MatrixType, M2: MatrixType>(m1: M1, m2: M2, operation: @escaping (M1.T, M2.T) -> T) {
        precondition(m1.nRows == m2.nRows)
        precondition(m1.nColumns == m2.nColumns)

        self.elementAccessor    = { operation(m1[row: $0, column: $1], m2[row: $0, column: $1]) }
        self.rowAccessor        = { RowMap(v1: m1[row: $0], v2: m2[row: $0], operation: operation) }
        self.columnAccessor     = { ColumnMap(v1: m1[column: $0], v2: m2[column: $0], operation: operation) }
        self.nRows              = m1.nRows
        self.nColumns           = m1.nColumns
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

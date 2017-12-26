//
//  MatrixOperation.swift
//  Matrices
//
//  Created by Andrea Tomarelli on 26/12/17.
//

public struct MatrixOperation<T: Numeric>: MatrixType {
    
    private let elementAccessor:    (Int, Int) -> T
    
    private let rowAccessor:        (Int) -> RowOperation<T>
    
    private let columnAccessor:     (Int) -> ColumnOperation<T>
    
    public let nRows:               Int
    
    public let nColumns:            Int
    
    
    public init<M: MatrixType>(matrix: M, operation: @escaping (T) -> T) where M.T == T {
        self.elementAccessor    = { operation(matrix[row: $0, column: $1]) }
        self.rowAccessor        = { RowOperation(vector: matrix[row: $0], operation: operation) }
        self.columnAccessor     = { ColumnOperation(vector: matrix[column: $0], operation: operation) }
        self.nRows              = matrix.nRows
        self.nColumns           = matrix.nColumns
    }
    
    init<M1: MatrixType, M2: MatrixType>(m1: M1, m2: M2, operation: @escaping (T, T) -> T) where M1.T == T, M2.T == T {
        precondition(m1.nRows == m2.nRows)
        precondition(m1.nColumns == m2.nColumns)

        self.elementAccessor    = { operation(m1[row: $0, column: $1], m2[row: $0, column: $1]) }
        self.rowAccessor        = { RowOperation(v1: m1[row: $0], v2: m2[row: $0], operation: operation) }
        self.columnAccessor     = { ColumnOperation(v1: m1[column: $0], v2: m2[column: $0], operation: operation) }
        self.nRows              = m1.nRows
        self.nColumns           = m1.nColumns
    }
    
    init<C: ColumnVectorType, R: RowVectorType>(multiplying columnVector: C, by rowVector: R) where C.T == T, R.T == T {
        self.elementAccessor    = { columnVector[$0] * rowVector[$1] }
        self.rowAccessor        = { i in RowOperation(vector: rowVector, operation: { columnVector[i] * $0 }) }
        self.columnAccessor     = { i in ColumnOperation(vector: columnVector, operation: { $0 * rowVector[i] }) }
        self.nRows              = columnVector.length
        self.nColumns           = rowVector.length
    }
    
}

public extension MatrixOperation {
    
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

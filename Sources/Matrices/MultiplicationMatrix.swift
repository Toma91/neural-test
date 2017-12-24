//
//  MultiplicationMatrix.swift
//  Matrices
//
//  Created by Andrea Tomarelli on 20/12/17.
//

public struct MultiplicationMatrix<T: Numeric>: MatrixType {
    
    private let elementAccessor:    (Int, Int) -> T

    private let rowAccessor:        (Int) -> RowMap<T>

    private let columnAccessor:     (Int) -> ColumnMap<T>
    
    public let nRows:               Int

    public let nColumns:            Int

    
    init<C: ColumnVectorType, R: RowVectorType>(multiplying column: C, by row: R) where C.T == T, R.T == T {
        self.elementAccessor    = { column[$0] * row[$1] }
        self.rowAccessor        = { column[$0] * row }
        self.columnAccessor     = { column * row[$0] }
        self.nRows              = column.length
        self.nColumns           = row.length
    }
    
}

public extension MultiplicationMatrix {
    
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

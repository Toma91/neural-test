//
//  MultiplicationMatrix.swift
//  Matrices
//
//  Created by Andrea Tomarelli on 20/12/17.
//

public struct MultiplicationMatrix<T: Numeric>: MatrixType {
    
    private let accessor:   (Int, Int) -> T
    
    public let nRows:       Int

    public let nColumns:    Int

    
    init<C: ColumnVectorType, R: RowVectorType>(multiplying column: C, by row: R) where C.T == T, R.T == T {
        self.accessor = { column[$0] * row[$1] }
        self.nRows      = row.length
        self.nColumns   = column.length
    }
    
}

public extension MultiplicationMatrix {
    
    subscript(row row: Int, column column: Int) -> T {
        get { return accessor(row, column) }
    }
    
}

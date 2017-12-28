//
//  ColumnDotRowOperation.swift
//  Matrices
//
//  Created by Andrea Tomarelli on 27/12/17.
//

public struct ColumnDotRowOperation<T: Numeric> {
    
    private let accessor:   (Int, Int) -> T

    let nRows:              Int
    
    let nColumns:           Int
    
    
    init(lhs: ColumnVector<T>, rhs: RowVector<T>) {
        self.accessor   = { lhs[$0] * rhs[$1] }
        self.nRows      = lhs.length
        self.nColumns   = rhs.length
    }
    
    
    subscript(row row: Int, column column: Int) -> T {
        get { return accessor(row, column) }
    }
    
}

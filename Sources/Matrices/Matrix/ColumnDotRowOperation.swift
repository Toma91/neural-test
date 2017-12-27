//
//  ColumnDotRowOperation.swift
//  Matrices
//
//  Created by Andrea Tomarelli on 27/12/17.
//

public struct ColumnDotRowOperation<T: Numeric> {
    
    private let accessor:   (Int, Int) -> T

    private let nRows:      Int
    
    private let nColumns:   Int
    
    
    init(lhs: ColumnVector<T>, rhs: RowVector<T>) {
        self.accessor   = { lhs[$0] * rhs[$1] }
        self.nRows      = lhs.length
        self.nColumns   = rhs.length
    }
    
    
    func execute(into matrix: inout Matrix<T>)  {
        if matrix.nRows != nRows || matrix.nColumns != nColumns {
            matrix = Matrix(nRows: nRows, nColumns: nColumns)
        }
        
        for r in 0 ..< nRows {
            for c in 0 ..< nColumns {
                matrix[row: r, column: c] = accessor(r, c)
            }
        }
    }
    
}

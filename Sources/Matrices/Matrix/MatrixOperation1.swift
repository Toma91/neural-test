//
//  MatrixOperation1.swift
//  Matrices
//
//  Created by Andrea Tomarelli on 27/12/17.
//

public struct MatrixOperation1<T: Numeric> {
  
    private let accessor:   (Int, Int) -> T
    
    private let nRows:      Int
    
    private let nColumns:   Int
    
    
    init(lhs: Matrix<T>, rhs: T, operation: @escaping (T, T) -> T) {
        self.accessor   = { operation(lhs[row: $0, column: $1], rhs) }
        self.nRows      = lhs.nRows
        self.nColumns   = lhs.nColumns
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

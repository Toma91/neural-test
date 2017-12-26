//
//  TransposedMatrix.swift
//  Matrices
//
//  Created by Andrea Tomarelli on 26/12/17.
//

public struct TransposedMatrix<T: Numeric>: MatrixType {
   
    private let accessor:   (Int, Int) -> T

    public let nRows:       Int
    
    public let nColumns:    Int
    
    
    init<M: MatrixType>(transposing matrix: M) where M.T == T {
        self.accessor   = { matrix[row: $1, column: $0] }
        self.nRows      = matrix.nColumns
        self.nColumns   = matrix.nRows
    }
    
}

public extension TransposedMatrix {

    var ᵀ: TransposedMatrix<T> { return TransposedMatrix(transposing: self) }
    
}

public extension TransposedMatrix {

    subscript(row row: Int, column column: Int) -> T {
        get { return accessor(row, column) }
    }
    
}

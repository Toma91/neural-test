//
//  TransposedMatrix.swift
//  Matrices
//
//  Created by Andrea Tomarelli on 26/12/17.
//

public struct TransposedMatrix<T: Numeric> {
   
    private let matrix:     Matrix<T>
    
    public let nRows:       Int
    
    public let nColumns:    Int
    
    
    init(transposing matrix: Matrix<T>) {
        self.matrix     = matrix
        self.nRows      = matrix.nColumns
        self.nColumns   = matrix.nRows
    }
    
}

public extension TransposedMatrix {

    var ᵀ: Matrix<T> { return matrix }
    
}

public extension TransposedMatrix {

    subscript(row row: Int, column column: Int) -> T {
        get { return matrix[row: column, column: row] }
    }
    
}

//
//  TransposedMatrix.swift
//  Matrices
//
//  Created by Andrea Tomarelli on 26/12/17.
//

public struct TransposedMatrix<T: Numeric> {
   
    private let matrix: Matrix<T>
    
    
    public var nRows:       Int { return matrix.nColumns }
    
    public var nColumns:    Int { return matrix.nRows }
    
    
    init(transposing matrix: Matrix<T>) {
        self.matrix = matrix
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

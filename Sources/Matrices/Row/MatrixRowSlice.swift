//
//  MatrixRowSlice.swift
//  Matrices
//
//  Created by Andrea Tomarelli on 26/12/17.
//

public struct MatrixRowSlice<T: Numeric>: RowVectorType {
 
    private let matrix: Matrix<T>
    
    private let row:    Int
    
    public let length:  Int
    
    
    init(matrix: Matrix<T>, row: Int) {
        precondition(row >= 0 && row < matrix.nRows)
    
        self.matrix = matrix
        self.row    = row
        self.length = matrix.nColumns
    }
    
}

public extension MatrixRowSlice {
    
    subscript(index: Int) -> T {
        get { return matrix[row: row, column: index] }
    }
    
}

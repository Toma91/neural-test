//
//  MatrixSliceRow.swift
//  Matrices
//
//  Created by Andrea Tomarelli on 14/12/17.
//

import Foundation

public struct MatrixSliceRow<T: Numeric>: RowVectorType {
    
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

public extension MatrixSliceRow {
    
    subscript(index: Int) -> T {
        get {
            precondition(index >= 0 && index < length)

            return matrix[row: row, column: index]
        }
    }
    
}

//
//  MatrixSliceRow.swift
//  Matrices
//
//  Created by Andrea Tomarelli on 14/12/17.
//

import Foundation

public struct MatrixSliceColumn<T: Numeric>: ColumnVectorType {
    
    private let matrix: Matrix<T>
    
    private let column: Int
    
    public let length:  Int
    
    
    init(matrix: Matrix<T>, column: Int) {
        precondition(column >= 0 && column < matrix.nColumns)
        
        self.matrix = matrix
        self.column = column
        self.length = matrix.nRows
    }
    
}

public extension MatrixSliceColumn {
    
    subscript(index: Int) -> T {
        get {
            precondition(index >= 0 && index < length)

            return matrix[row: index, column: column]
        }
    }
    
}

//
//  MatrixColumnSlice.swift
//  Matrices
//
//  Created by Andrea Tomarelli on 26/12/17.
//

public struct MatrixColumnSlice<T: Numeric>: ColumnVectorType {
 
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

public extension MatrixColumnSlice {
    
    subscript(index: Int) -> T {
        get { return matrix[row: index, column: column] }
    }
    
}

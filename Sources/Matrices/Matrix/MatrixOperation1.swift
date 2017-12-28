//
//  MatrixOperation1.swift
//  Matrices
//
//  Created by Andrea Tomarelli on 27/12/17.
//

public struct MatrixOperation1<T: Numeric> {
  
    private let accessor:   (Int, Int) -> T
   
    let nRows:              Int
    
    let nColumns:           Int
    
    
    init(lhs: Matrix<T>, rhs: T, operation: @escaping (T, T) -> T) {
        self.accessor   = { operation(lhs[row: $0, column: $1], rhs) }
        self.nRows      = lhs.nRows
        self.nColumns   = lhs.nColumns
    }
    
    
    subscript(row row: Int, column column: Int) -> T {
        get { return accessor(row, column) }
    }
    
}

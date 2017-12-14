//
//  MatrixSliceRow.swift
//  Matrices
//
//  Created by Andrea Tomarelli on 14/12/17.
//

import Foundation

public struct MatrixSliceRow<T: Numeric> {
    
    private enum Kind {
        
        case row(Int)
        case mul(RowVector<T>)
        
    }
    
    
    private let matrix: Matrix<T>
    
    private let kind:   Kind
    
    
    var length: Int { return matrix.nColumns }
    
    
    init(matrix: Matrix<T>, row: Int) {
        precondition(row >= 0 && row < matrix.nRows)
        
        self.matrix = matrix
        self.kind = .row(row)
    }
    
    
    init(vector: RowVector<T>, multiplying matrix: Matrix<T>) {
        precondition(vector.length == matrix.nRows)
        
        self.matrix = matrix
        self.kind = .mul(vector)
    }
    
}

extension MatrixSliceRow {
    
    subscript(index: Int) -> T {
        get {
            precondition(index >= 0 && index < length)
            
            switch kind {
                
            case .row(let r):
                return matrix[row: r, column: index]

            case .mul(let v):
                return (0 ..< matrix.nRows).reduce(0) {
                    $0 + v[$1] * matrix[row: $1, column: index]
                }
                
            }
        }
    }
    
}

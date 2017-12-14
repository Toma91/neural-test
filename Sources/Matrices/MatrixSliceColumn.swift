//
//  MatrixSliceRow.swift
//  Matrices
//
//  Created by Andrea Tomarelli on 14/12/17.
//

import Foundation

public struct MatrixSliceColumn<T: Numeric> {
    
    private enum Kind {
        
        case column(Int)
        case mul(ColumnVector<T>)
        
    }
    
    
    private let matrix: Matrix<T>
    
    private let kind:   Kind
    
    
    var length: Int { return matrix.nRows }
    
    
    init(matrix: Matrix<T>, column: Int) {
        precondition(column >= 0 && column < matrix.nColumns)
        
        self.matrix = matrix
        self.kind = .column(column)
    }
    
    
    init(matrix: Matrix<T>, multiplying vector: ColumnVector<T>) {
        precondition(matrix.nColumns == vector.length)
        
        self.matrix = matrix
        self.kind = .mul(vector)
    }
    
}

extension MatrixSliceColumn {
    
    subscript(index: Int) -> T {
        get {
            precondition(index >= 0 && index < length)
            
            switch kind {
                
            case .column(let c):
                return matrix[row: index, column: c]

            case .mul(let v):
                return (0 ..< matrix.nColumns).reduce(0) {
                    $0 + matrix[row: index, column: $1] * v[$1]
                }
                
            }
        }
    }
    
}

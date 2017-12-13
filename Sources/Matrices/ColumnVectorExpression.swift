//
//  ColumnVectorExpression.swift
//  Matrices
//
//  Created by Andrea Tomarelli on 13/12/17.
//

public struct ColumnVectorExpression<T: Numeric> {
    
    private let matrix: Matrix<T>

    private let vector: ColumnVector<T>
    
    
    var length: Int {
        return matrix.dimensions.nRows
    }
    
    
    init(matrix: Matrix<T>, vector: ColumnVector<T>) {
        precondition(vector.length == matrix.dimensions.nColumns)
        
        self.matrix = matrix
        self.vector = vector
    }
    
}

extension ColumnVectorExpression {
    
    subscript(index: Int) -> T {
        get {
            precondition(index >= 0 && index < length)
            
            return (0 ..< matrix.dimensions.nColumns).reduce(0) {
                $0 + vector[$1] * matrix[row: index, column: $1]
            }
        }
    }
    
}

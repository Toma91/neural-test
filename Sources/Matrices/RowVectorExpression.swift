//
//  RowVectorExpression.swift
//  Matrices
//
//  Created by Andrea Tomarelli on 13/12/17.
//

public struct RowVectorExpression<T: Numeric> {
    
    private let vector: RowVector<T>
    
    private let matrix: Matrix<T>?
    
    
    var length: Int {
        return matrix?.dimensions.nColumns ?? vector.length
    }
    
    
    init(vector: RowVector<T>, matrix: Matrix<T>? = nil) {
        precondition(matrix == nil || vector.length == matrix!.dimensions.nRows)
        
        self.vector = vector
        self.matrix = matrix
    }
    
}

extension RowVectorExpression {
    
    subscript(index: Int) -> T {
        get {
            precondition(index >= 0 && index < length)
            
            guard let m = matrix else { return vector[index] }
            
            return (0 ..< m.dimensions.nRows).reduce(0) {
                $0 + vector[$1] * m[row: $1, column: index]
            }
        }
    }
    
}

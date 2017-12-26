//
//  MatrixColumnDot.swift
//  Matrices
//
//  Created by Andrea Tomarelli on 26/12/17.
//

public struct MatrixColumnDot<T: Numeric> {

    private let length: Int

    private let matrix: Matrix<T>
    
    private let vector: ColumnVector<T>
    
    
    init(matrix: Matrix<T>, vector: ColumnVector<T>) {
        precondition(matrix.nColumns == vector.length)
        
        self.length = matrix.nRows
        self.matrix = matrix
        self.vector = vector
    }
    
    
    func assign(to vector: inout ColumnVector<T>) {
        if vector.length == length {
            for i in 0 ..< length {
                vector[i] = 0
                
                for c in 0 ..< matrix.nColumns {
                    vector[i] += matrix[row: i, column: c] * vector[c]
                }
            }
        } else {
            let storage = Storage<T>(size: length)
            
            for i in 0 ..< length {
                storage[i] = 0
                
                for c in 0 ..< matrix.nColumns {
                    storage[i] += matrix[row: i, column: c] * vector[c]
                }
            }
            
            vector = ColumnVector(storage: storage)
        }
    }
    
}

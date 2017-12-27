//
//  MatrixDotColumnOperation.swift
//  Matrices
//
//  Created by Andrea Tomarelli on 27/12/17.
//

public struct MatrixDotColumnOperation<T: Numeric> {

    private let accessor:   (Int) -> T
    
    let length:             Int

    
    init(lhs: Matrix<T>, rhs: ColumnVector<T>) {
        precondition(lhs.nColumns == rhs.length)
     
        let accessor = { (r: Int) -> T in
            var result: T = 0
            
            for c in 0 ..< lhs.nColumns {
                result += lhs[row: r, column: c] * rhs[c]
            }
            
            return result
        }
        
        self.accessor = accessor
        self.length = lhs.nRows
    }
    
    
    func execute(into vector: inout ColumnVector<T>)  {
        if vector.length != length {
            vector = ColumnVector(length: length)
        }
        
        for i in 0 ..< length { vector[i] = accessor(i) }
    }
    
    
    subscript(index: Int) -> T {
        get { return accessor(index) }
    }
    
}
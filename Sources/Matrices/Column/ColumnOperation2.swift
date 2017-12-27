//
//  ColumnOperation2.swift
//  Matrices
//
//  Created by Andrea Tomarelli on 26/12/17.
//

public struct ColumnOperation2<T: Numeric> {
    
    init(lhs: MatrixDotColumnOperation<T>, rhs: ColumnVector<T>, operation: (T, T) -> T) {
        fatalError()
    }
    
    init(lhs: ColumnOperation1<T>, rhs: ColumnVector<T>, operation: (T, T) -> T) {
        fatalError()        
    }
    
    init(lhs: ColumnVector<T>, rhs: ColumnVector<T>, operation: (T, T) -> T) {
        fatalError()
    }

    func execute(into vector: inout ColumnVector<T>)  {
        fatalError()
    }
    
}

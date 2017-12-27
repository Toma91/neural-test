//
//  ColumnOperation1.swift
//  Matrices
//
//  Created by Andrea Tomarelli on 26/12/17.
//

public struct ColumnOperation1<T: Numeric> {
    
    init(lhs: T, rhs: ColumnOperation2<T>, operation: (T, T) -> T) {
        fatalError()
    }
    
    init(lhs: ColumnVector<T>, rhs: T, operation: (T, T) -> T) {
        fatalError()
    }
    
    func execute(into vector: inout ColumnVector<T>)  {
        fatalError()
    }
    
}

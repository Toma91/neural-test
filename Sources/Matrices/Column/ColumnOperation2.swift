//
//  ColumnOperation2.swift
//  Matrices
//
//  Created by Andrea Tomarelli on 26/12/17.
//

public struct ColumnOperation2<T: Numeric> {
  
    private let accessor:   (Int) -> T

    let length:             Int

    
    init(lhs: MatrixDotColumnOperation<T>, rhs: ColumnVector<T>, operation: @escaping (T, T) -> T) {
        precondition(lhs.length == rhs.length)
        
        self.accessor   = { operation(lhs[$0], rhs[$0]) }
        self.length     = lhs.length
    }
    
    init(lhs: ColumnOperation1<T>, rhs: ColumnVector<T>, operation: @escaping (T, T) -> T) {
        precondition(lhs.length == rhs.length)
        
        self.accessor   = { operation(lhs[$0], rhs[$0]) }
        self.length     = lhs.length
    }
    
    init(lhs: ColumnVector<T>, rhs: ColumnVector<T>, operation: @escaping (T, T) -> T) {
        precondition(lhs.length == rhs.length)
        
        self.accessor   = { operation(lhs[$0], rhs[$0]) }
        self.length     = lhs.length
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

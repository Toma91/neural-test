//
//  ColumnOperation1.swift
//  Matrices
//
//  Created by Andrea Tomarelli on 26/12/17.
//

public struct ColumnOperation1<T: Numeric> {

    private let accessor:   (Int) -> T
    
    let length:             Int
    
    
    init(lhs: T, rhs: ColumnOperation2<T>, operation: @escaping (T, T) -> T) {
        self.accessor   = { operation(lhs, rhs[$0]) }
        self.length     = rhs.length
    }
    
    init(lhs: ColumnVector<T>, rhs: T, operation: @escaping (T, T) -> T) {
        self.accessor   = { operation(lhs[$0], rhs) }
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

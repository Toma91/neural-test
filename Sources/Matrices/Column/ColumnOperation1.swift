//
//  ColumnOperation1.swift
//  Matrices
//
//  Created by Andrea Tomarelli on 26/12/17.
//

public struct ColumnOperation1<T: Numeric> {

    private let accessor:   (Int) -> T
    
    public let length:      Int
    

    public init(vector: ColumnOperation2<T>, operation: @escaping (T) -> T) {
        self.accessor   = { operation(vector[$0]) }
        self.length     = vector.length
    }
    
    init(lhs: T, rhs: ColumnOperation2<T>, operation: @escaping (T, T) -> T) {
        self.accessor   = { operation(lhs, rhs[$0]) }
        self.length     = rhs.length
    }
    
    init(lhs: ColumnVector<T>, rhs: T, operation: @escaping (T, T) -> T) {
        self.accessor   = { operation(lhs[$0], rhs) }
        self.length     = lhs.length
    }
    
    
    subscript(index: Int) -> T {
        get { return accessor(index) }
    }
    
}

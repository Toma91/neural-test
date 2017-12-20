//
//  RowTransposed.swift
//  Matrices
//
//  Created by Andrea Tomarelli on 18/12/17.
//

public struct RowTransposed<T: Numeric>: RowVectorType {
   
    private let accessor:   (Int) -> T
    
    public let length:      Int
    
    
    init<V: ColumnVectorType>(transposing vector: V) where V.T == T {
        self.accessor   = { vector[$0] }
        self.length     = vector.length
    }
    
}

public extension RowTransposed {
    
    subscript(index: Int) -> T {
        get { return accessor(index) }
    }
    
}

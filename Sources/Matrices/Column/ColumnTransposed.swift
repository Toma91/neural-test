//
//  ColumnTransposed.swift
//  Matrices
//
//  Created by Andrea Tomarelli on 18/12/17.
//

public struct ColumnTransposed<T: Numeric>: ColumnVectorType {
   
    private let accessor:   (Int) -> T
    
    public let length:      Int
    
    
    init<V: RowVectorType>(transposing vector: V) where V.T == T {
        self.accessor   = { vector[$0] }
        self.length     = vector.length
    }
    
}

public extension ColumnTransposed {
    
    subscript(index: Int) -> T {
        get { return accessor(index) }
    }
    
}

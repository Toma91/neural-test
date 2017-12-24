//
//  ColumnTransposed.swift
//  Matrices
//
//  Created by Andrea Tomarelli on 18/12/17.
//

public struct ColumnTransposed<T: Numeric>: ColumnVectorType {
   
    private let elementAccessor:    (Int) -> T
    
    public let length:              Int
    
    
    init<V: RowVectorType>(transposing vector: V) where V.T == T {
        self.elementAccessor    = { vector[$0] }
        self.length             = vector.length
    }
    
}

public extension ColumnTransposed {
    
    subscript(index: Int) -> T {
        get { return elementAccessor(index) }
    }
    
}

public func transpose<V: RowVectorType>(_ vector: V) -> ColumnTransposed<V.T> {
    return ColumnTransposed(transposing: vector)
}

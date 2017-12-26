//
//  Array+init.swift
//  Matrices
//
//  Created by Andrea Tomarelli on 16/12/17.
//

public extension Array where Element: Numeric {
    
    init<V: ColumnVectorType>(vector: V) where V.T == Element {
        self = (0 ..< vector.length).map { vector[$0] }
    }
    
    init<V: RowVectorType>(vector: V) where V.T == Element {
        self = (0 ..< vector.length).map { vector[$0] }
    }
    
}

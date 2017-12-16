//
//  Array+init.swift
//  Matrices
//
//  Created by Andrea Tomarelli on 16/12/17.
//

public extension Array where Element: Numeric {
    
    init(vector: ColumnVector<Element>) {
        self = (0 ..< vector.length).map { vector[$0] }
    }
    
    init(vector: RowVector<Element>) {
        self = (0 ..< vector.length).map { vector[$0] }
    }
    
}

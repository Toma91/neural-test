//
//  ColumnVectorType.swift
//  Matrices
//
//  Created by Andrea Tomarelli on 26/12/17.
//

public protocol ColumnVectorType {
    
    associatedtype T: Numeric
    
    var length: Int { get }
    
    subscript(index: Int) -> T { get }
    
}

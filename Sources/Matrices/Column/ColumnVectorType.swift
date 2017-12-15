//
//  ColumnVectorType.swift
//  learnPackageDescription
//
//  Created by Andrea Tomarelli on 15/12/17.
//

public protocol ColumnVectorType {

    associatedtype T: Numeric
    
    var length: Int { get }
    
    subscript(index: Int) -> T { get }
    
}

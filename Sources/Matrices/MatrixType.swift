//
//  MatrixType.swift
//  Matrices
//
//  Created by Andrea Tomarelli on 20/12/17.
//

public protocol MatrixType {
    
    associatedtype T: Numeric
    
    var nRows: Int { get }

    var nColumns: Int { get }

    subscript(row row: Int, column column: Int) -> T { get }
    
}

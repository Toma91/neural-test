//
//  MatrixType.swift
//  Matrices
//
//  Created by Andrea Tomarelli on 20/12/17.
//

public protocol MatrixType {
    
    associatedtype T
    
    associatedtype R: RowVectorType where R.T == T
    
    associatedtype C: ColumnVectorType where C.T == T
    

    var nRows: Int { get }

    var nColumns: Int { get }

    
    subscript(row row: Int, column column: Int) -> T { get }

    subscript(row row: Int) -> R { get }
    
    subscript(column column: Int) -> C { get }

}

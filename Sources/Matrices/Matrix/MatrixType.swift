//
//  MatrixType.swift
//  Matrices
//
//  Created by Andrea Tomarelli on 26/12/17.
//

public protocol MatrixType {
    
    associatedtype T
    
    associatedtype RowSlice: RowVectorType where RowSlice.T == T
    
    associatedtype ColumnSlice: ColumnVectorType where ColumnSlice.T == T

    
    var nRows: Int { get }

    var nColumns: Int { get }

    
    subscript(row row: Int, column column: Int) -> T { get }
    
    subscript(row row: Int) -> RowSlice { get }
    
    subscript(column column: Int) -> ColumnSlice { get }
    
}

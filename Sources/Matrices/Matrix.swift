//
//  Matrix.swift
//  learnPackageDescription
//
//  Created by Andrea Tomarelli on 12/12/17.
//

public struct Matrix<T: Numeric> {
    
    private let storage:    Storage<T>
    
    public let nRows:       Int
    
    public let nColumns:    Int
    
    
    public init(nRows: Int, nColumns: Int, elements: T...) {
        precondition(elements.isEmpty || elements.count == nRows * nColumns)
        
        let storage = elements.isEmpty
            ? Storage(size: nRows * nColumns)
            : Storage(elements: elements)
        
        self.storage    = storage
        self.nRows      = nRows
        self.nColumns   = nColumns
    }
    
}

public extension Matrix {
    
    subscript(row row: Int, column column: Int) -> T {
        get {
            precondition(row >= 0 && row < nRows)
            precondition(column >= 0 && column < nColumns)

            return storage[row * nColumns + column]
        }
        set {
            precondition(row >= 0 && row < nRows)
            precondition(column >= 0 && column < nColumns)
            
            storage[row * nColumns + column] = newValue
        }
    }
    
}

public extension Matrix {
    
    subscript(row row: Int) -> MatrixSliceRow<T> {
        get {
            precondition(row >= 0 && row < nRows)
            
            return MatrixSliceRow(matrix: self, row: row)
        }
        set {
            precondition(row >= 0 && row < nRows)
            precondition(newValue.length == nColumns)
            
            for i in 0 ..< nColumns {
                storage[row * nColumns + i] = newValue[i]
            }
        }
    }
    
}

public extension Matrix {
    
    subscript(column column: Int) -> MatrixSliceColumn<T> {
        get {
            precondition(column >= 0 && column < nColumns)
            
            return MatrixSliceColumn(matrix: self, column: column)
        }
        set {
            precondition(column >= 0 && column < nColumns)
            precondition(newValue.length == nRows)
            
            for i in 0 ..< nRows {
                storage[i * nColumns + column] = newValue[i]
            }
        }
    }
    
}


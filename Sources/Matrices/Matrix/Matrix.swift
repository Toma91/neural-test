//
//  Matrix.swift
//  learnPackageDescription
//
//  Created by Andrea Tomarelli on 12/12/17.
//

public struct Matrix<T: Numeric>: MatrixType {
    
    private var storage:    Storage<T>
    
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

    public init<M: MatrixType>(_ other: M) where M.T == T {
        let storage = Storage<T>(size: other.nRows * other.nColumns)
        
        for r in 0 ..< other.nRows {
            for c in 0 ..< other.nColumns {
                storage[r * other.nColumns + c] = other[row: r, column: c]
            }
        }
        
        self.storage    = storage
        self.nRows      = other.nRows
        self.nColumns   = other.nColumns
    }
    
}

public extension Matrix {
    
    var ᵀ: TransposedMatrix<T> {
        return TransposedMatrix(transposing: self)
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
            
            if !isKnownUniquelyReferenced(&storage) {
                storage = Storage(copying: storage)
            }
            
            storage[row * nColumns + column] = newValue
        }
    }
    
}

public extension Matrix {
    
    subscript(row row: Int) -> MatrixRowSlice<T> {
        get {
            precondition(row >= 0 && row < nRows)
            
            return MatrixRowSlice(matrix: self, row: row)
        }
    }
        
    subscript(column column: Int) -> MatrixColumnSlice<T> {
        get {
            precondition(column >= 0 && column < nColumns)

            return MatrixColumnSlice(matrix: self, column: column)            
        }
    }
    
}


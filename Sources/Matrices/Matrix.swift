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
    
}

extension Matrix {

    func multiply<V: ColumnVectorType>(row: Int, by vector: V) -> T where V.T == T {
        precondition(row >= 0 && row < nRows)
        precondition(nColumns == vector.length)
        
        return (0 ..< nColumns).reduce(0) {
            $0 + self[row: row, column: $1] * vector[$1]
        }
    }
    
    func multiply<V: RowVectorType>(vector: V, byColumn column: Int) -> T where V.T == T {
        precondition(column >= 0 && column < nColumns)
        precondition(nRows == vector.length)
        
        return (0 ..< nRows).reduce(0) {
            $0 + vector[$1] * self[row: $1, column: column]
        }
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
    
    subscript(row row: Int) -> RowMatrixSlice<T> {
        get {
            precondition(row >= 0 && row < nRows)
            
            return RowMatrixSlice(matrix: self, row: row)
        }
        set {
            precondition(row >= 0 && row < nRows)
            precondition(newValue.length == nColumns)
            
            if !isKnownUniquelyReferenced(&storage) {
                storage = Storage(copying: storage)
            }
            
            for i in 0 ..< nColumns {
                storage[row * nColumns + i] = newValue[i]
            }
        }
    }
    
}

public extension Matrix {
    
    subscript(column column: Int) -> ColumnMatrixSlice<T> {
        get {
            precondition(column >= 0 && column < nColumns)
            
            return ColumnMatrixSlice(matrix: self, column: column)
        }
        set {
            precondition(column >= 0 && column < nColumns)
            precondition(newValue.length == nRows)
            
            if !isKnownUniquelyReferenced(&storage) {
                storage = Storage(copying: storage)
            }
            
            for i in 0 ..< nRows {
                storage[i * nColumns + column] = newValue[i]
            }
        }
    }
    
}


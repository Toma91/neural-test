//
//  Matrix.swift
//  learnPackageDescription
//
//  Created by Andrea Tomarelli on 12/12/17.
//

public struct Matrix<T: Numeric> {
    
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

public extension Matrix {

    var ᵀ: Matrix<T> {
        var result = Matrix<T>(nRows: nColumns, nColumns: nRows)
        
        for r in 0 ..< nRows {
            for c in 0 ..< nColumns {
                result[row: c, column: r] = self[row: r, column: c]
            }
        }
        
        return result
    }
    
    func map<U>(_ transform: (T) throws -> U) rethrows -> Matrix<U> {
        var result = Matrix<U>(nRows: nRows, nColumns: nColumns)
        
        for r in 0 ..< nRows {
            for c in 0 ..< nColumns {
                result[row: r, column: c] = try transform(self[row: r, column: c])
            }
        }
        
        return result
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
    
    subscript(row row: Int) -> RowVector<T> {
        get {
            precondition(row >= 0 && row < nRows)
            
            var result = RowVector<T>(length: nColumns)

            for i in 0 ..< nColumns {
                result[i] = storage[row * nColumns + i]
            }

            return result
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
    
    subscript(column column: Int) -> ColumnVector<T> {
        get {
            precondition(column >= 0 && column < nColumns)
        
            
            var result = ColumnVector<T>(length: nRows)
            
            for i in 0 ..< nRows {
                result[i] = storage[i * nColumns + column]
            }
            
            return result
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


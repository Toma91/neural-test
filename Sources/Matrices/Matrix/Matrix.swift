//
//  Matrix.swift
//  Matrices
//
//  Created by Andrea Tomarelli on 12/12/17.
//

public struct Matrix<T: Numeric> {
    
    private var storage:    Storage<T>
    
    public let nRows:       Int
    
    public let nColumns:    Int
    
    
    init(storage: Storage<T>, nRows: Int, nColumns: Int) {
        precondition(storage.count == nRows * nColumns)
        
        self.storage    = storage
        self.nRows      = nRows
        self.nColumns   = nColumns
    }
    
}

public extension Matrix {
    
    static func zeros(nRows: Int, nColumns: Int) -> Matrix<T> {
        let storage = Storage<T>(size: nRows * nColumns)
        for i in 0 ..< nRows * nColumns { storage[i] = 0 }
        
        return Matrix<T>(storage: storage, nRows: nRows, nColumns: nColumns)
    }
    
    
    var ᵀ: TransposedMatrix<T> {
        return TransposedMatrix(transposing: self)
    }
    
    
    init(nRows: Int, nColumns: Int, elements: T...) {
        precondition(elements.isEmpty || elements.count == nRows * nColumns)
        
        let storage = elements.isEmpty
            ? Storage(size: nRows * nColumns)
            : Storage(elements: elements)
        
        self.init(storage: storage, nRows: nRows, nColumns: nColumns)
    }
    
    init() {
        self.init(storage: Storage(size: 0), nRows: 0, nColumns: 0)
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

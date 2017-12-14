//
//  M.swift
//  Matrices
//
//  Created by Andrea Tomarelli on 13/12/17.
//

final class Storage<T> {

    private let buffer: UnsafeMutableBufferPointer<T>

    
    init(size: Int) {
        self.buffer = UnsafeMutableBufferPointer(
            start: UnsafeMutablePointer.allocate(capacity: size),
            count: size
        )
    }
    
}

extension Storage {

    
    convenience init(copying storage: Storage<T>) {
        self.init(size: storage.buffer.count)
        
        buffer.baseAddress!.assign(
            from: storage.buffer.baseAddress!,
            count: storage.buffer.count
        )
    }
    
    convenience init(elements: [T]) {
        self.init(size: elements.count)
        
        buffer.baseAddress!.assign(from: elements, count: elements.count)
    }
    
}

extension Storage {

    subscript(index: Int) -> T {
        get { return buffer[index] }
        set { buffer[index] = newValue }
    }
    
}

struct Matrix<T> {
    
    private let storage:    Storage<T>
    
    private let offset:     Int

    let nRows:              Int
    
    let nColumns:           Int
    
    
    init(nRows: Int, nColumns: Int, elements: T...) {
        precondition(elements.isEmpty || elements.count == nRows * nColumns)
        
        self.storage    = Storage(size: nRows * nColumns)
        self.offset     = 0
        self.nRows      = nRows
        self.nColumns   = nColumns
        
        var i = elements.makeIterator()
        
        for row in 0 ..< nRows {
            for col in 0 ..< nColumns {
                self[row: row, column: col] = i.next()!
            }
        }
    }

    init(row elements: T...) {
        self.storage    = Storage(elements: elements)
        self.offset     = 0
        self.nRows      = 1
        self.nColumns   = elements.count
    }
    
    init(column elements: T...) {
        self.storage    = Storage(elements: elements)
        self.offset     = 0
        self.nRows      = elements.count
        self.nColumns   = 1
    }
    
    private init(sharing storage: Storage<T>, offset: Int, nRows: Int, nColumns: Int) {
        self.storage    = storage
        self.offset     = offset
        self.nRows      = nRows
        self.nColumns   = nColumns
    }

}

extension Matrix {
    
    subscript(row row: Int) -> Matrix<T> {
        get {
            precondition(row >= 0 && row < nRows)
            
            return Matrix(sharing: storage, offset: row * nColumns, nRows: 1, nColumns: nColumns)
        }
        set {
            precondition(row >= 0 && row < nRows)
            precondition(newValue.nRows == 1 && newValue.nColumns == nColumns)
            
            for column in 0 ..< nColumns {
                self[row: row, column: column] = newValue[row: 0, column: column]
            }
        }
    }
    
    subscript(column column: Int) -> Matrix<T> {
        get {
            precondition(column >= 0 && column < nColumns)

            return Matrix(sharing: storage, offset: column, nRows: nRows, nColumns: 1)

        }
        set {
            precondition(column >= 0 && column < nColumns)
            precondition(newValue.nColumns == 1 && newValue.nRows == nRows)
            
            for row in 0 ..< nRows {
                self[row: row, column: column] = newValue[row: row, column: 0]
            }
        }
    }
    
    subscript(row row: Int, column column: Int) -> T {
        get {
            precondition(row >= 0 && row < nRows)
            precondition(column >= 0 && column < nColumns)
            
            print("idx", row * nColumns + offset + column, row, nColumns, offset, column)

            return storage[row * nColumns + offset + column]
        }
        set {
            precondition(row >= 0 && row < nRows)
            precondition(column >= 0 && column < nColumns)
            
            storage[row * nColumns + offset + column] = newValue
        }
    }
    
}




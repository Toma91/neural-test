//
//  Matrix2.swift
//  learnPackageDescription
//
//  Created by Andrea Tomarelli on 12/12/17.
//

public struct Martix2<T> {
    
    public typealias Dimensions = (nRows: Int, nColumns: Int)
    
    
    private var storage:    Storage<T>
    
    public let dimensions:  Dimensions
    
    
    init(storage: Storage<T>, dimensions: Dimensions) {
        self.storage    = storage
        self.dimensions = dimensions
    }

}

public extension Martix2 {
    
    init(dimensions: Dimensions) {
        self.init(
            storage: Storage(size: dimensions.0 * dimensions.1),
            dimensions: dimensions
        )
    }
    
}

public extension Martix2 {

    subscript(row row: Int) -> RowVector<T> {
        get {
            precondition(row >= 0 && row < dimensions.nRows)
            
            return RowVector(
                storage: storage,
                offset: row * dimensions.nColumns,
                step: 1,
                length: dimensions.nColumns
            )
        }
        set {
            precondition(row >= 0 && row < dimensions.nRows)
            
            if !isKnownUniquelyReferenced(&storage) {
                storage = Storage(copying: storage)
            }
            
            for (column, i) in stride(from: row, to: storage.count, by: 1).enumerated() {
                storage[i] = newValue[column]
            }
        }
    }
    
    subscript(column column: Int) -> ColumnVector<T> {
        get {
            precondition(column >= 0 && column < dimensions.nColumns)
            
            return ColumnVector(
                storage: storage,
                offset: column,
                step: dimensions.nColumns,
                length: dimensions.nRows
            )
        }
        set {
            precondition(column >= 0 && column < dimensions.nColumns)

            if !isKnownUniquelyReferenced(&storage) {
                storage = Storage(copying: storage)
            }
            
            for (row, i) in stride(from: column, to: storage.count, by: dimensions.nColumns).enumerated() {
                storage[i] = newValue[row]
            }
        }
    }
    
    subscript(row row: Int, column column: Int) -> T {
        get {
            precondition(row >= 0 && row < dimensions.nRows)
            precondition(column >= 0 && column < dimensions.nColumns)
            
            return storage[row * dimensions.nColumns + column]
        }
        set {
            precondition(row >= 0 && row < dimensions.nRows)
            precondition(column >= 0 && column < dimensions.nColumns)
         
            if !isKnownUniquelyReferenced(&storage) {
                storage = Storage(copying: storage)
            }
            
            storage[row * dimensions.nColumns + column] = newValue
        }
    }
    
}

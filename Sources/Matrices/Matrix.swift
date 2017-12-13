//
//  Matrix.swift
//  learnPackageDescription
//
//  Created by Andrea Tomarelli on 12/12/17.
//

public struct Matrix<T: Numeric> {
    
    public typealias Dimensions = (nRows: Int, nColumns: Int)
    
    
    private var storage:    Storage<T>
    
    public let dimensions:  Dimensions
    
    
    init(storage: Storage<T>, dimensions: Dimensions) {
        self.storage    = storage
        self.dimensions = dimensions
    }

}

public extension Matrix {
    
    init(dimensions: Dimensions) {
        self.init(
            storage: Storage(size: dimensions.0 * dimensions.1),
            dimensions: dimensions
        )
    }
    
}

public extension Matrix {

    mutating func set(row: Int, to vectorProducer: RowVectorExpression<T>) {
        precondition(vectorProducer.length == dimensions.nColumns)
     
        if !isKnownUniquelyReferenced(&storage) {
            storage = Storage(copying: storage)
        }
        
        for i in 0 ..< vectorProducer.length {
            storage[row * dimensions.nColumns + i] = vectorProducer[i]
        }
    }
    
}

func test() {
    let a = RowVector<Int>(length: 5)
    let b = Matrix<Int>(dimensions: (5, 4))
    
    var m = Matrix<Int>(dimensions: (3, 4))
    m[row: 0] = a * b
    
//    let t = m[row: 0]
}

public extension Matrix {

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
            self[row: row] = RowVectorExpression(vector: newValue)
        }
    }
    
    subscript(row row: Int) -> RowVectorExpression<T> {
        get {
            return RowVectorExpression(vector: self[row: row])
        }
        set {
            precondition(row >= 0 && row < dimensions.nRows)
            precondition(newValue.length == dimensions.nColumns)

            if !isKnownUniquelyReferenced(&storage) {
                storage = Storage(copying: storage)
            }
            
            for (column, i) in stride(from: row, to: dimensions.nColumns, by: 1).enumerated() {
                storage[i] = newValue[column]
            }
        }
    }
}

public extension Matrix {
    
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

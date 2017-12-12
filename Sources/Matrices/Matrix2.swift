//
//  Matrix2.swift
//  learnPackageDescription
//
//  Created by Andrea Tomarelli on 12/12/17.
//

public struct Martix2<T> {
    
    public typealias Dimensions = (Int, Int)
    
    
    private let storage:    MatrixStorage<T>
    
    private let offset:     Int
    
    public let dimensions:  Dimensions
    
    
    public init(dimensions: Dimensions) {
        self.storage    = MatrixStorage(size: dimensions.0 * dimensions.1)
        self.offset     = 0
        self.dimensions = dimensions
    }
    
    init(storage: MatrixStorage<T>, offset: Int, dimensions: Dimensions) {
        self.storage    = storage
        self.offset     = offset
        self.dimensions = dimensions
    }

}

public extension Martix2 {

    subscript(_ i0: Int) -> Vector<T> {
        get {
            precondition(i0 >= 0 && i0 < dimensions.0)
            
            return Vector(
                storage: storage,
                offset: offset + i0 * dimensions.1,
                length: dimensions.1
            )
        }
    }
    
    subscript(_ i0: Int, _ i1: Int) -> T {
        get {
            precondition(i0 >= 0 && i0 < dimensions.0)
            precondition(i1 >= 0 && i1 < dimensions.1)
            
            return storage[offset + i0 * dimensions.1 + i1]
        }
    }
    
}

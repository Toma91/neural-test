//
//  Matrix3.swift
//  learnPackageDescription
//
//  Created by Andrea Tomarelli on 12/12/17.
//

public struct Martix3<T> {
    
    public typealias Dimensions = (Int, Int, Int)
    
    
    private let storage:    MatrixStorage<T>
    
    public let dimensions:  Dimensions
    
    
    public init(dimensions: Dimensions) {
        self.storage    = MatrixStorage(size: dimensions.0 * dimensions.1 * dimensions.2)
        self.dimensions = dimensions
    }

}

public extension Martix3 {
    
    subscript(_ i0: Int) -> Martix2<T> {
        get {
            precondition(i0 >= 0 && i0 < dimensions.0)
            
            return Martix2(
                storage: storage,
                offset: i0 * (dimensions.1 * dimensions.2),
                dimensions: (dimensions.1, dimensions.2)
            )
        }
    }
    
    subscript(_ i0: Int, _ i1: Int) -> Vector<T> {
        get {
            precondition(i0 >= 0 && i0 < dimensions.0)
            precondition(i1 >= 0 && i1 < dimensions.1)
            
            return Vector(
                storage: storage,
                offset: i0 * (dimensions.1 * dimensions.2) + i1 * dimensions.2,
                length: dimensions.2
            )
        }
    }
    
    subscript(_ i0: Int, _ i1: Int, _ i2: Int) -> T {
        get {
            precondition(i0 >= 0 && i0 < dimensions.0)
            precondition(i1 >= 0 && i1 < dimensions.1)
            precondition(i2 >= 0 && i2 < dimensions.2)
            
            return storage[i0 * (dimensions.1 * dimensions.2) + i1 * dimensions.2 + i2]
        }
    }
    
}

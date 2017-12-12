//
//  Matrix3.swift
//  learnPackageDescription
//
//  Created by Andrea Tomarelli on 12/12/17.
//

private final class MatrixStorage<T> {

    private let buffer: UnsafeMutableBufferPointer<T>

    
    init(size: Int) {
        self.buffer = UnsafeMutableBufferPointer.allocate(capacity: size)
    }
    
    deinit {
        buffer.deallocate()
    }
    
    
    subscript(index: Int) -> T {
        get {
            return buffer[index]
        }
    }
    
}

public struct Vector<T> {
    
    private let storage:    MatrixStorage<T>
    
    private let offset:     Int
    
    let length:             Int
    
    
    public init(length: Int) {
        self.storage    = MatrixStorage(size: length)
        self.offset     = 0
        self.length     = length
    }
    
    fileprivate init(storage: MatrixStorage<T>, offset: Int, length: Int) {
        self.storage    = storage
        self.offset     = offset
        self.length     = length
    }
    
    
    public subscript(index: Int) -> T {
        get {
            precondition(index >= 0 && index < length)
            
            return storage[offset + index]
        }
    }
    
}

public struct Martix2<T> {
   
    public typealias Dimensions = (Int, Int)
    
    
    private let storage:    MatrixStorage<T>
    
    private let offset:     Int
    
    let dimensions:         Dimensions
    
    
    public init(dimensions: Dimensions) {
        self.storage    = MatrixStorage(size: dimensions.0 * dimensions.1)
        self.offset     = 0
        self.dimensions = dimensions
    }
    
    fileprivate init(storage: MatrixStorage<T>, offset: Int, dimensions: Dimensions) {
        self.storage    = storage
        self.offset     = offset
        self.dimensions = dimensions
    }
    
    
    public subscript(_ i0: Int) -> Vector<T> {
        get {
            precondition(i0 >= 0 && i0 < dimensions.0)
            
            return Vector(
                storage: storage,
                offset: offset + i0 * dimensions.1,
                length: dimensions.1
            )
        }
    }
    
    public subscript(_ i0: Int, _ i1: Int) -> T {
        get {
            precondition(i0 >= 0 && i0 < dimensions.0)
            precondition(i1 >= 0 && i1 < dimensions.1)

            return storage[offset + i0 * dimensions.1 + i1]
        }
    }
    
}

public struct Martix3<T> {
    
    public typealias Dimensions = (Int, Int, Int)
    

    private let storage:    MatrixStorage<T>

    let dimensions:         Dimensions
    
    
    public init(dimensions: Dimensions) {
        self.storage    = MatrixStorage(size: dimensions.0 * dimensions.1 * dimensions.2)
        self.dimensions = dimensions
    }
    
    
    public subscript(_ i0: Int) -> Martix2<T> {
        get {
            precondition(i0 >= 0 && i0 < dimensions.0)
            
            return Martix2(
                storage: storage,
                offset: i0 * (dimensions.1 * dimensions.2),
                dimensions: (dimensions.1, dimensions.2)
            )
        }
    }
    
    public subscript(_ i0: Int, _ i1: Int) -> Vector<T> {
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
    
    public subscript(_ i0: Int, _ i1: Int, _ i2: Int) -> T {
        get {
            precondition(i0 >= 0 && i0 < dimensions.0)
            precondition(i1 >= 0 && i1 < dimensions.1)
            precondition(i2 >= 0 && i2 < dimensions.2)

            return storage[i0 * (dimensions.1 * dimensions.2) + i1 * dimensions.2 + i2]
        }
    }
    
}

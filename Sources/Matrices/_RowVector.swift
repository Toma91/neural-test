//
//  _RowVector.swift
//  Matrices
//
//  Created by Andrea Tomarelli on 26/12/17.
//

public struct RowVector<T: Numeric> {
    
    private var storage: Storage<T>
    
    
    public var length: Int { return storage.count }
    
    
    init(storage: Storage<T>) {
        self.storage = storage
    }

}

public extension RowVector {
    
    static func zeros(length: Int) -> RowVector<T> {
        let storage = Storage<T>(size: length)
        for i in 0 ..< length { storage[i] = 0 }
        
        return RowVector<T>(storage: storage)
    }
    
    
    var ᵀ: ColumnVector<T> { return ColumnVector(storage: storage) }
    
    
    init() {
        self.init(storage: Storage(size: 0))
    }
    
    init(length: Int) {
        self.init(storage: Storage(size: length))
    }
    
    init(elements: [T]) {
        self.init(storage: Storage(elements: elements))
    }

}

public extension RowVector {
    
    subscript(index: Int) -> T {
        get {
            precondition(index >= 0 && index < length)
            
            return storage[index]
        }
        set {
            precondition(index >= 0 && index < length)

            if !isKnownUniquelyReferenced(&storage) {
                storage = Storage(copying: storage)
            }
            
            storage[index] = newValue
        }
    }
    
}


/*
public struct RowVector<T: Numeric> {
   
    public let length: Int = 0

    public subscript(index: Int) -> T {
        get { fatalError() }
    }
    
}

public struct Matrix<T: Numeric> {
    
    public let nRows: Int = 0
    
    public let nColumns: Int = 0
    
    public init() {
        fatalError()
    }
    
    public init(nRows: Int, nColumns: Int) {
        fatalError()
    }
    
    public var ᵀ: Matrix<T> {
        fatalError()
    }
    
    public subscript(row row: Int, column column: Int) -> T {
        get { fatalError() }
        set { fatalError() }
    }
    
}

public func -<T>(lhs: ColumnVector<T>, rhs: ColumnVector<T>) -> ColumnVector<T> {
    fatalError()
}

public func *<T>(lhs: T, rhs: ColumnVector<T>) -> ColumnVector<T> {
    fatalError()
}

infix operator •: MultiplicationPrecedence

public func •<T>(lhs: Matrix<T>, rhs: ColumnVector<T>) -> ColumnVector<T> {
    fatalError()
}

public func +<T>(lhs: ColumnVector<T>, rhs: ColumnVector<T>) -> ColumnVector<T> {
    fatalError()
}

infix operator <~: AssignmentPrecedence

public func <~<T>(lhs: inout ColumnVector<T>, rhs: ColumnVector<T>) {
    fatalError()
}

public func <~<T>(lhs: inout Matrix<T>, rhs: Matrix<T>) {
    fatalError()
}

public func *<T>(lhs: ColumnVector<T>, rhs: ColumnVector<T>) -> ColumnVector<T> {
    fatalError()
}

public func •<T>(lhs: ColumnVector<T>, rhs: RowVector<T>) -> Matrix<T> {
    fatalError()
}

public func +=<T>(lhs: inout Matrix<T>, rhs: Matrix<T>) {
    fatalError()
}

public func +=<T>(lhs: inout ColumnVector<T>, rhs: ColumnVector<T>) {
    fatalError()
}

public func /<T: FloatingPoint>(lhs: Matrix<T>, rhs: T) -> Matrix<T> {
    fatalError()
}

public func *<T>(lhs: Matrix<T>, rhs: T) -> Matrix<T> {
    fatalError()
}

public func -=<T>(lhs: inout Matrix<T>, rhs: Matrix<T>) {
    fatalError()
}

public func /<T: FloatingPoint>(lhs: ColumnVector<T>, rhs: T) -> ColumnVector<T> {
    fatalError()
}

public func *<T>(lhs: ColumnVector<T>, rhs: T) -> ColumnVector<T> {
    fatalError()
}

public func -=<T>(lhs: inout ColumnVector<T>, rhs: ColumnVector<T>) {
    fatalError()
}
*/

//
//  _ColumnVector.swift
//  Matrices
//
//  Created by Andrea Tomarelli on 26/12/17.
//

public struct ColumnVector<T: Numeric> {
    
    public let length: Int = 0
    
    public init(length: Int) {
        fatalError()
    }
    
    public init(elements: [T]) {
        fatalError()
    }
    
    public var ᵀ: RowVector<T> {
        fatalError()
    }
    
    public subscript(index: Int) -> T {
        get { fatalError() }
        set { fatalError() }
    }
    
}

public struct RowVector<T: Numeric> {
   
    public let length: Int = 0

    public subscript(index: Int) -> T {
        get { fatalError() }
    }
    
}

public struct Matrix<T: Numeric> {
    
    public let nRows: Int = 0
    
    public let nColumns: Int = 0
    
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

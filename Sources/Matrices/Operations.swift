//
//  Operations.swift
//  Matrices
//
//  Created by Andrea Tomarelli on 13/12/17.
//

infix operator <~: AssignmentPrecedence

public final class RowMultiplication<T: Numeric> {
 
    private let vector: RowVector<T>

    private let matrix: Matrix2<T>
    
    
    init(vector: RowVector<T>, matrix: Matrix2<T>) {
        self.vector = vector
        self.matrix = matrix
    }
 
    subscript(index: Int) -> T {
        get {
            return (0 ..< vector.length).reduce(0) {
                $0 + vector[$1] * matrix[row: $1, column: index]
            }
        }
    }

}

public func <~<T>(lhs: inout RowVector<T>, rhs: RowMultiplication<T>) {
    lhs.assign(from: rhs)
}

public func *<T>(lhs: RowVector<T>, rhs: Matrix2<T>) -> RowMultiplication<T> {
    return RowMultiplication(vector: lhs, matrix: rhs)
}

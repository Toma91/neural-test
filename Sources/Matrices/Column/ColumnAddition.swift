//
//  ColumnAddition.swift
//  learnPackageDescription
//
//  Created by Andrea Tomarelli on 15/12/17.
//

public struct ColumnAddition<T: Numeric>: ColumnVectorType {

    private let lhs:    (Int) -> T
    
    private let rhs:    (Int) -> T
    
    public let length:  Int

    
    init<V1: ColumnVectorType, V2: ColumnVectorType>(lhs: V1, rhs: V2) where V1.T == T, V2.T == T {
        precondition(lhs.length == rhs.length)
        
        self.lhs    = { lhs[$0] }
        self.rhs    = { rhs[$0] }
        self.length = lhs.length
    }
    
}

public extension ColumnAddition {
    
    subscript(index: Int) -> T {
        get {
            precondition(index >= 0 && index < length)
            
            return lhs(index) + rhs(index)
        }
    }
    
}

//
//  ColumnOperation1.swift
//  learnPackageDescription
//
//  Created by Andrea Tomarelli on 26/12/17.
//

public struct ColumnOperation1<T: Numeric> {
    
    private let length:     Int
    
    private let v1:         ColumnVector<T>
    
    private let operation:  (T) -> T
    
    
    public init(v1: ColumnVector<T>, operation: @escaping (T) -> T) {
        self.length     = v1.length
        self.v1         = v1
        self.operation  = operation
    }
    
    public init(v1: ColumnOperation2<T>, operation: @escaping (T) -> T) {
        var _v1 = ColumnVector<T>(length: 0)
        v1.assign(to: &_v1)
        
        self.init(v1: _v1, operation: operation)
    }
    
    
    func assign(to vector: inout ColumnVector<T>) {
        if vector.length == length {
            for i in 0 ..< length {
                vector[i] = operation(v1[i])
            }
        } else {
            let storage = Storage<T>(size: length)
            
            for i in 0 ..< length {
                storage[i] = operation(v1[i])
            }
            
            vector = ColumnVector(storage: storage)
        }
    }
    
}

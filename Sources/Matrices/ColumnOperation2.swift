//
//  ColumnOperation2.swift
//  Matrices
//
//  Created by Andrea Tomarelli on 26/12/17.
//

public struct ColumnOperation2<T: Numeric> {
    
    private let length:     Int
    
    private let v1:         ColumnVector<T>
    
    private let v2:         ColumnVector<T>
    
    private let operation:  (T, T) -> T
    
    
    init(v1: ColumnVector<T>, v2: ColumnVector<T>, operation: @escaping (T, T) -> T) {
        precondition(v1.length == v2.length)
        
        self.length     = v1.length
        self.v1         = v1
        self.v2         = v2
        self.operation  = operation
    }
    
    init(v1: MatrixColumnDot<T>, v2: ColumnVector<T>, operation: @escaping (T, T) -> T) {
        var _v1 = ColumnVector<T>(length: 0)
        v1.assign(to: &_v1)
        
        self.init(v1: _v1, v2: v2, operation: operation)
    }
    
    init(v1: ColumnOperation1<T>, v2: ColumnVector<T>, operation: @escaping (T, T) -> T) {
        var _v1 = ColumnVector<T>(length: 0)
        v1.assign(to: &_v1)
        
        self.init(v1: _v1, v2: v2, operation: operation)
    }
    
    func assign(to vector: inout ColumnVector<T>) {
        if vector.length == length {
            for i in 0 ..< length {
                vector[i] = operation(v1[i], v2[i])
            }
        } else {
            let storage = Storage<T>(size: length)
            
            for i in 0 ..< length {
                storage[i] = operation(v1[i], v2[i])
            }
            
            vector = ColumnVector(storage: storage)
        }
    }
    
}

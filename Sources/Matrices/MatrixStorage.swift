//
//  MatrixStorage.swift
//  learnPackageDescription
//
//  Created by Andrea Tomarelli on 12/12/17.
//

final class MatrixStorage<T> {
    
    private let _storage:   UnsafeMutablePointer<T>
    
    private let buffer:     UnsafeMutableBufferPointer<T>
    
    
    init(size: Int) {
        let storage = UnsafeMutablePointer<T>.allocate(capacity: size)
        
        self._storage = storage
        self.buffer = UnsafeMutableBufferPointer(start: storage, count: size)
    }
    
    deinit {
        _storage.deallocate(capacity: buffer.count)
    }
    
}

extension MatrixStorage {
    
    subscript(index: Int) -> T {
        get {
            return buffer[index]
        }
        set {
            buffer[index] = newValue
        }
    }
    
}

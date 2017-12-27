//
//  Storage.swift
//  Matrices
//
//  Created by Andrea Tomarelli on 12/12/17.
//

final class Storage<T> {
    
    private let buffer: UnsafeMutableBufferPointer<T>
    
    var count:          Int { return buffer.count }

    
    init(size: Int) {
        self.buffer = UnsafeMutableBufferPointer(
            start: UnsafeMutablePointer.allocate(capacity: size),
            count: size
        )
    }
    
    deinit {
        buffer.baseAddress!.deallocate(capacity: buffer.count)
    }
    
}

extension Storage {
    
    convenience init(copying storage: Storage<T>) {
        self.init(size: storage.buffer.count)
        
        buffer.baseAddress!.assign(
            from: storage.buffer.baseAddress!,
            count: storage.buffer.count
        )
    }
    
    convenience init(elements: [T]) {
        self.init(size: elements.count)
        
        buffer.baseAddress!.assign(from: elements, count: elements.count)
    }
    
}

extension Storage {
    
    subscript(index: Int) -> T {
        @inline(__always) get { return buffer[index] }
        @inline(__always) set { buffer[index] = newValue }
    }
    
}

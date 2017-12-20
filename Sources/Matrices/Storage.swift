//
//  Storage.swift
//  learnPackageDescription
//
//  Created by Andrea Tomarelli on 12/12/17.
//

final class Storage<T> {
    
    private let buffer: UnsafeMutableBufferPointer<T>
    
    
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
        get { return buffer[index] }
        set { buffer[index] = newValue }
    }
    
}

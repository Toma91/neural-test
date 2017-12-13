//
//  Storage.swift
//  learnPackageDescription
//
//  Created by Andrea Tomarelli on 12/12/17.
//

final class Storage<T> {
    
    private let buffer: UnsafeMutableBufferPointer<T>
    
    var count: Int { return buffer.count }
    
    
    init(owning pointer: UnsafeMutablePointer<T>, count: Int) {
        print("init")
        
        self.buffer = UnsafeMutableBufferPointer(start: pointer, count: count)
    }
    
    deinit {
        buffer.baseAddress!.deallocate(capacity: buffer.count)
    }
    
}

extension Storage {
    
    convenience init(size: Int) {
        self.init(owning: UnsafeMutablePointer.allocate(capacity: size), count: size)
    }
    
    convenience init(copying storage: Storage, from offset: Int, count: Int) {
        precondition(offset >= 0 && offset < storage.count, "Invalid offset")
        precondition(count > 0 && offset + count <= storage.count, "Invalid offset + count")
        
        self.init(size: storage.count)
        
        buffer.baseAddress!.assign(
            from: storage.buffer.baseAddress!.advanced(by: offset),
            count: count
        )
    }
    
    convenience init(copying storage: Storage) {
        self.init(copying: storage, from: 0, count: storage.count)
    }
    
}

extension Storage {
    
    subscript(index: Int) -> T {
        get { return buffer[index] }
        set { buffer[index] = newValue }
    }
    
}

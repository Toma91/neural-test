//
//  IdxFile.swift
//  Neural
//
//  Created by Andrea Tomarelli on 09/12/17.
//

import Darwin.C

public class IdxFile {
    
    private let fd:         Int32
    
    private var storage:    UnsafePointer<UInt8>

    private let mapping:    UnsafeBufferPointer<UInt8>
    
    public let dimensions:  [Int]
    
    
    public init?(path: String) {
        let fd = open(path, O_RDONLY)
        guard fd > 0 else { return nil }
        
        let size = Int(lseek(fd, 0, SEEK_END))
        
        guard
            size >= 4,
            let ptr = mmap(nil, size, PROT_READ, MAP_SHARED, fd, 0)
            else { return nil }
        
        let ptr8 = ptr.assumingMemoryBound(to: UInt8.self)
        let ptr32 = ptr.assumingMemoryBound(to: UInt32.self)
        
        let mapping = UnsafeBufferPointer(start: ptr8, count: size)
        guard mapping[2] == 0x08 else { return nil }

        let nDimensions = Int(mapping[3])
        guard size >= 4 * (1 + nDimensions) else { return nil }

        let dimensions = (0 ..< nDimensions).map {
            Int(ptr32[$0 + 1].swapped)
        }
        
        self.fd         = fd
        self.storage    = UnsafePointer(ptr8)
        self.mapping    = mapping
        self.dimensions = dimensions
    }
    
    deinit {
        munmap(
            UnsafeMutableRawPointer(mutating: mapping.baseAddress),
            mapping.count
        )
        
        close(fd)
    }
    
}

public extension IdxFile {
    
    subscript(index: Int) -> UnsafeBufferPointer<UInt8> {
        get {
            precondition(index < dimensions[0], "Invalid index not in range 0 ..< \(dimensions[0])")
            
            let offset = dimensions.count.advanced(by: 1) * 4
            let size = dimensions.suffix(from: 1).reduce(1, *)
            
            return UnsafeBufferPointer(start: storage.advanced(by: offset + index * size), count: size)
        }
    }
    
}


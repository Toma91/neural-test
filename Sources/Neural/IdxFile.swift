//
//  IdxFile.swift
//  Neural
//
//  Created by Andrea Tomarelli on 09/12/17.
//

import Darwin.C

public class IdxFile {
    
    private let fd:             Int32
    
    private var storage:        UnsafePointer<UInt8>

    private let mapping:        UnsafeBufferPointer<UInt8>
    
    public let numberOfItems:   Int
    
    public let width:           Int
    
    public let height:          Int
    
    
    public init?(path: String) {
        let fd = open(path, O_RDONLY)
        guard fd > 0 else { return nil }
        
        let size = Int(lseek(fd, 0, SEEK_END))
        
        guard
            size >= 16,
            let ptr = mmap(nil, size, PROT_READ, MAP_SHARED, fd, 0)
            else { return nil }
        
        let ptr8 = ptr.assumingMemoryBound(to: UInt8.self)
        let ptr32 = ptr.assumingMemoryBound(to: UInt32.self)
        
        let mapping = UnsafeBufferPointer(start: ptr8, count: size)
        if mapping[3] != 3 { return nil }
        
        let numberOfItems = Int(ptr32[1].swapped)
        let w = Int(ptr32[2].swapped)
        let h = Int(ptr32[3].swapped)
        
        self.fd             = fd
        self.storage        = UnsafePointer(ptr8)
        self.mapping        = mapping
        self.numberOfItems  = numberOfItems
        self.width          = w
        self.height         = h
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
    
    subscript(index: Int) -> IdxImage {
        get {
            let offset = 16 + index * width * height
            
            precondition(
                offset < 16 + numberOfItems * width * height,
                "Invalid index \(index) not in range 0 ..< \(numberOfItems)"
            )
            
            return IdxImage(
                storage: UnsafeBufferPointer(
                    start: storage.advanced(by: offset),
                    count: width * height
                ),
                width: width,
                height: height
            )
        }
    }
    
}


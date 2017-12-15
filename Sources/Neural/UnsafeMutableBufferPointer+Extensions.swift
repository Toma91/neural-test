//
//  UnsafeMutableBufferPointer+Extensions.swift
//  Neural
//
//  Created by Andrea Tomarelli on 09/12/17.
//

extension UnsafeMutableBufferPointer {
    
    func slice(from offset: Int, count: Int) -> MutableRandomAccessSlice<UnsafeMutableBufferPointer> {
        return self[offset ..< offset.advanced(by: count)]
    }
    
}

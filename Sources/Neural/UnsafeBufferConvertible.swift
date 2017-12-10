//
//  UnsafeBufferConvertible.swift
//  Neural
//
//  Created by Andrea Tomarelli on 10/12/17.
//

public protocol UnsafeBufferConvertible {
    
    associatedtype Element
    
    var count: Int { get }
    
    func withUnsafeBufferPointer<R>(_ body: (UnsafeBufferPointer<Element>) throws -> R) rethrows -> R
    
}

extension Array: UnsafeBufferConvertible { }

extension UnsafeBufferPointer: UnsafeBufferConvertible {
    
    public func withUnsafeBufferPointer<R>(_ body: (UnsafeBufferPointer<Element>) throws -> R) rethrows -> R {
        return try body(self)
    }
    
}

extension UnsafeMutableBufferPointer: UnsafeBufferConvertible {
    
    public func withUnsafeBufferPointer<R>(_ body: (UnsafeBufferPointer<Element>) throws -> R) rethrows -> R {
        return try body(UnsafeBufferPointer(rebasing: self[0 ..< count]))
    }
    
}

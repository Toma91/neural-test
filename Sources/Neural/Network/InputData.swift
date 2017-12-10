//
//  InputData.swift
//  learnPackageDescription
//
//  Created by Andrea Tomarelli on 10/12/17.
//

public struct InputData {
    
    private let storage: AnyRandomAccessCollection<Double>
    
    
    public init<C: RandomAccessCollection>(_ c: C)
        where
        C.Element == Double,
        C.Indices: RandomAccessCollection,
        C.SubSequence: RandomAccessCollection,
        C.SubSequence.Indices: RandomAccessCollection {
            
        self.storage = AnyRandomAccessCollection(c)
    }
    
}

extension InputData: RandomAccessCollection {
    
    public var startIndex: AnyIndex {
        return storage.startIndex
    }
    
    public var endIndex: AnyIndex {
        return storage.endIndex
    }
    
    
    public func index(after i: AnyIndex) -> AnyIndex {
        return storage.index(after: i)
    }
    
    public func index(before i: AnyIndex) -> AnyIndex {
        return storage.index(before: i)
    }
    
    
    public subscript(position: AnyIndex) -> Double {
        return storage[position]
    }
    
}

//
//  Vector.swift
//  Neural
//
//  Created by Andrea Tomarelli on 09/12/17.
//

struct Vector<T> {
    
    private let memory: UnsafeBufferPointer<T>

    var length: Int { return memory.count }

    
    init(memory: UnsafeBufferPointer<T>) {
        self.memory = memory
    }
    
}

extension Vector {
    
    subscript(index: Int) -> T {
        get {
            precondition(
                index < length,
                "Invalid index \(index) not in range 0 ..< \(length)"
            )
            
            return memory[index]
        }
    }
    
}

struct VectorIterator<T>: IteratorProtocol {
    
    private let vector: Vector<T>
    
    private var index:  Int = 0
    
    
    init(_ vector: Vector<T>) {
        self.vector = vector
    }
    
    
    mutating func next() -> T? {
        guard index < vector.length else { return nil }
        
        let result = vector[index]
        index += 1
        
        return result
    }
    
}

extension Vector: Sequence {
    
    func makeIterator() -> VectorIterator<T> {
        return VectorIterator(self)
    }
    
}

func *<T: Numeric>(lhs: Vector<T>, rhs: Vector<T>) -> T {
    precondition(
        lhs.length == rhs.length,
        "Dot product between vectors of different lengths (\(lhs.length) vs \(rhs.length))"
    )
    
    return zip(lhs, rhs).reduce(into: 0) { $0 += $1.0 * $1.1 }
}

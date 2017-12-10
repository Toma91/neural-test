//
//  Collection+Multiplication.swift
//  Neural
//
//  Created by Andrea Tomarelli on 09/12/17.
//

func *<C1: Collection, C2: Collection, E: Numeric>(lhs: C1, rhs: C2) -> E where C1.Element == E, C2.Element == E {
    precondition(
        lhs.count == rhs.count,
        "Product between collections of different lengths (\(lhs.count) vs \(rhs.count))"
    )
    
    return zip(lhs, rhs).reduce(0) { $0 + $1.0 * $1.1 }
}

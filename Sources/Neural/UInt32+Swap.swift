//
//  UInt32+Swap.swift
//  Neural
//
//  Created by Andrea Tomarelli on 09/12/17.
//

extension UInt32 {
    
    var swapped: UInt32 {
        let b0 = self >> 24 & 0x000000FF
        let b1 = self >> 08 & 0x0000FF00
        let b2 = self << 08 & 0x00FF0000
        let b3 = self << 24 & 0xFF000000
        
        return UInt32(b3 | b2 | b1 | b0)
    }
    
}


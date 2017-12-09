//
//  IdxImage.swift
//  Neural
//
//  Created by Andrea Tomarelli on 09/12/17.
//

public struct IdxImage {

    private let storage:    UnsafeBufferPointer<UInt8>

    public let width:      Int
    
    public let height:     Int
    
    
    init(storage: UnsafeBufferPointer<UInt8>, width: Int, height: Int) {
        precondition(
            storage.count == width * height,
            "storage size \(storage.count) does not match size \(width)x\(height)"
        )
        
        self.storage    = storage
        self.width      = width
        self.height     = height
    }
    
}

public extension IdxImage {
    
    func asNetworkInput() -> [Double] {
        let m = Double(storage.max() ?? 0)

        return Array(storage).map(Double.init).map { $0 / m }
    }
    
}

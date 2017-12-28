//
//  ColumnOperation2Tests.swift
//  MatricesTests
//
//  Created by Andrea Tomarelli on 13/12/17.
//

import XCTest
@testable import Matrices

class ColumnOperation2Tests: XCTestCase {
    
    func test_ColumnOperation1_ColumnVector_operation() {
        let cv1 = ColumnVector(1, 2, 3, 4)
        let co2 = ColumnOperation1(lhs: cv1, rhs: 2, operation: *)
        let cv2 = ColumnVector(5, 6, 7, 8)
        
        let v = ColumnOperation2(lhs: co2, rhs: cv2, operation: +)
        
        XCTAssertEqual(v.length, 4)
        XCTAssertEqual(v[0], 7)
        XCTAssertEqual(v[1], 10)
        XCTAssertEqual(v[2], 13)
        XCTAssertEqual(v[3], 16)
    }
    
}

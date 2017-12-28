//
//  ColumnOperation1Tests.swift
//  MatricesTests
//
//  Created by Andrea Tomarelli on 13/12/17.
//

import XCTest
@testable import Matrices

class ColumnOperation1Tests: XCTestCase {
    
    func test_ColumnOperation2_operation() {
        let cv1 = ColumnVector(1, 2, 3, 4)
        let cv2 = ColumnVector(5, 6, 7, 8)
        let co2 = ColumnOperation2(lhs: cv1, rhs: cv2, operation: +)
        
        let v = ColumnOperation1(vector: co2, operation: { $0 - 1 })
        
        XCTAssertEqual(v.length, 4)
        XCTAssertEqual(v[0], 5)
        XCTAssertEqual(v[1], 7)
        XCTAssertEqual(v[2], 9)
        XCTAssertEqual(v[3], 11)
    }
    
    func test_ColumnVector_operator_operation() {
        let cv = ColumnVector(1, 2, 3, 4)
        
        let v = ColumnOperation1(lhs: cv, rhs: 2, operation: *)
        
        XCTAssertEqual(v.length, 4)
        XCTAssertEqual(v[0], 2)
        XCTAssertEqual(v[1], 4)
        XCTAssertEqual(v[2], 6)
        XCTAssertEqual(v[3], 8)
    }
    
    func test_operator_ColumnOperation2_operation() {
        let cv1 = ColumnVector(1, 2, 3, 4)
        let cv2 = ColumnVector(5, 6, 7, 8)
        let co2 = ColumnOperation2(lhs: cv1, rhs: cv2, operation: +)
        
        let v = ColumnOperation1(lhs: 2, rhs: co2, operation: *)
        
        XCTAssertEqual(v.length, 4)
        XCTAssertEqual(v[0], 12)
        XCTAssertEqual(v[1], 16)
        XCTAssertEqual(v[2], 20)
        XCTAssertEqual(v[3], 24)
    }
    
}

//
//  MatricesTests.swift
//  MatricesTests
//
//  Created by Andrea Tomarelli on 13/12/17.
//

import XCTest
@testable import Matrices

class MatricesTests: XCTestCase {
    
    private var m = Matrix2<Int>(dimensions: (2, 3))
    
    override func setUp() {
        m[row: 0, column: 0] = 1
        m[row: 0, column: 1] = 2
        m[row: 0, column: 2] = 3
        m[row: 1, column: 0] = 4
        m[row: 1, column: 1] = 5
        m[row: 1, column: 2] = 6
    }
        
    func testMatrix() {
        XCTAssertEqual(m[row: 0, column: 0], 1)
        XCTAssertEqual(m[row: 0, column: 1], 2)
        XCTAssertEqual(m[row: 0, column: 2], 3)
        XCTAssertEqual(m[row: 1, column: 0], 4)
        XCTAssertEqual(m[row: 1, column: 1], 5)
        XCTAssertEqual(m[row: 1, column: 2], 6)
    }
    
    func testRowVector() {
        let v_r_0 = m[row: 0]
        let v_r_1 = m[row: 1]
        
        XCTAssertEqual(v_r_0[0], 1)
        XCTAssertEqual(v_r_0[1], 2)
        XCTAssertEqual(v_r_0[2], 3)
        XCTAssertEqual(v_r_1[0], 4)
        XCTAssertEqual(v_r_1[1], 5)
        XCTAssertEqual(v_r_1[2], 6)
    }
    
    func testColumnVector() {
        let v_c_0 = m[column: 0]
        let v_c_1 = m[column: 1]
        let v_c_2 = m[column: 2]

        XCTAssertEqual(v_c_0[0], 1)
        XCTAssertEqual(v_c_1[0], 2)
        XCTAssertEqual(v_c_2[0], 3)
        XCTAssertEqual(v_c_0[1], 4)
        XCTAssertEqual(v_c_1[1], 5)
        XCTAssertEqual(v_c_2[1], 6)
    }
    
    func testCow() {
        var mCopy = m
        
        XCTAssertEqual(m[row: 0, column: 0], mCopy[row: 0, column: 0])
        XCTAssertEqual(m[row: 0, column: 1], mCopy[row: 0, column: 1])
        XCTAssertEqual(m[row: 0, column: 2], mCopy[row: 0, column: 2])
        XCTAssertEqual(m[row: 1, column: 0], mCopy[row: 1, column: 0])
        XCTAssertEqual(m[row: 1, column: 1], mCopy[row: 1, column: 1])
        XCTAssertEqual(m[row: 1, column: 2], mCopy[row: 1, column: 2])
        
        mCopy[row: 0, column: 1] = 99
        mCopy[row: 1, column: 2] = 210

        XCTAssertEqual(m[row: 0, column: 0], mCopy[row: 0, column: 0])
        XCTAssertNotEqual(m[row: 0, column: 1], mCopy[row: 0, column: 1])
        XCTAssertEqual(m[row: 0, column: 1], 2)
        XCTAssertEqual(mCopy[row: 0, column: 1], 99)
        XCTAssertEqual(m[row: 0, column: 2], mCopy[row: 0, column: 2])
        XCTAssertEqual(m[row: 1, column: 0], mCopy[row: 1, column: 0])
        XCTAssertEqual(m[row: 1, column: 1], mCopy[row: 1, column: 1])
        XCTAssertNotEqual(m[row: 1, column: 2], mCopy[row: 1, column: 2])
        XCTAssertEqual(m[row: 1, column: 2], 6)
        XCTAssertEqual(mCopy[row: 1, column: 2], 210)
    
        m[row: 0, column: 1] = 99
        m[row: 1, column: 2] = 210

        XCTAssertEqual(m[row: 0, column: 0], mCopy[row: 0, column: 0])
        XCTAssertEqual(m[row: 0, column: 1], mCopy[row: 0, column: 1])
        XCTAssertEqual(m[row: 0, column: 2], mCopy[row: 0, column: 2])
        XCTAssertEqual(m[row: 1, column: 0], mCopy[row: 1, column: 0])
        XCTAssertEqual(m[row: 1, column: 1], mCopy[row: 1, column: 1])
        XCTAssertEqual(m[row: 1, column: 2], mCopy[row: 1, column: 2])
    }

    func testMultiplication() {
        var a = RowVector<Int>(length: 3)
        var b = Matrix2<Int>(dimensions: (3, 3))

        print("begin")

        a[0] = 1
        a[1] = 2
        a[2] = 3
        
        b[row: 0, column: 0] = 1
        b[row: 0, column: 1] = 2
        b[row: 0, column: 2] = 3
        b[row: 1, column: 0] = 4
        b[row: 1, column: 1] = 5
        b[row: 1, column: 2] = 6
        b[row: 2, column: 0] = 7
        b[row: 2, column: 1] = 8
        b[row: 2, column: 2] = 9

        m[row: 0] <~ a * b
        
        XCTAssertEqual(m[row: 0, column: 0], 30)
        XCTAssertEqual(m[row: 0, column: 1], 36)
        XCTAssertEqual(m[row: 0, column: 2], 42)

        print("end")
    }

}

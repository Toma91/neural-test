//
//  MatricesTests.swift
//  MatricesTests
//
//  Created by Andrea Tomarelli on 13/12/17.
//

import XCTest
@testable import Matrices

class MatricesTests: XCTestCase {

    func testRowVector() {
        var v = RowVector<Int>(length: 5)
        
        XCTAssertEqual(v.length, 5)
        
        v = RowVector(elements: [1, 2, 3, 4])
        
        XCTAssertEqual(v.length, 4)
        XCTAssertEqual(v[0], 1)
        XCTAssertEqual(v[1], 2)
        XCTAssertEqual(v[2], 3)
        XCTAssertEqual(v[3], 4)
        
        v = RowVector(3, 2, 1)
        
        XCTAssertEqual(v.length, 3)
        XCTAssertEqual(v[0], 3)
        XCTAssertEqual(v[1], 2)
        XCTAssertEqual(v[2], 1)
        
        v[0] = 10
        v[1] = 20
        v[2] = 30
        
        XCTAssertEqual(v.length, 3)
        XCTAssertEqual(v[0], 10)
        XCTAssertEqual(v[1], 20)
        XCTAssertEqual(v[2], 30)
    }
    
    func testColumnVector() {
        var v = ColumnVector<Int>(length: 5)
        
        XCTAssertEqual(v.length, 5)
        
        v = ColumnVector(elements: [1, 2, 3, 4])
        
        XCTAssertEqual(v.length, 4)
        XCTAssertEqual(v[0], 1)
        XCTAssertEqual(v[1], 2)
        XCTAssertEqual(v[2], 3)
        XCTAssertEqual(v[3], 4)
        
        v = ColumnVector(3, 2, 1)
        
        XCTAssertEqual(v.length, 3)
        XCTAssertEqual(v[0], 3)
        XCTAssertEqual(v[1], 2)
        XCTAssertEqual(v[2], 1)
        
        v[0] = 10
        v[1] = 20
        v[2] = 30
        
        XCTAssertEqual(v.length, 3)
        XCTAssertEqual(v[0], 10)
        XCTAssertEqual(v[1], 20)
        XCTAssertEqual(v[2], 30)
    }
    
    func testMatrix() {
        var m = Matrix<Int>(nRows: 3, nColumns: 4)

        XCTAssertEqual(m.nRows, 3)
        XCTAssertEqual(m.nColumns, 4)
        
        m = Matrix(nRows: 3, nColumns: 4, elements: 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12)

        XCTAssertEqual(m.nRows, 3)
        XCTAssertEqual(m.nColumns, 4)
        XCTAssertEqual(m[row: 0, column: 0], 1)
        XCTAssertEqual(m[row: 0, column: 1], 2)
        XCTAssertEqual(m[row: 0, column: 2], 3)
        XCTAssertEqual(m[row: 0, column: 3], 4)
        XCTAssertEqual(m[row: 1, column: 0], 5)
        XCTAssertEqual(m[row: 1, column: 1], 6)
        XCTAssertEqual(m[row: 1, column: 2], 7)
        XCTAssertEqual(m[row: 1, column: 3], 8)
        XCTAssertEqual(m[row: 2, column: 0], 9)
        XCTAssertEqual(m[row: 2, column: 1], 10)
        XCTAssertEqual(m[row: 2, column: 2], 11)
        XCTAssertEqual(m[row: 2, column: 3], 12)
        
        m[row: 0, column: 0] = 10
        m[row: 0, column: 1] = 20
        m[row: 0, column: 2] = 30
        m[row: 0, column: 3] = 40
        m[row: 1, column: 0] = 50
        m[row: 1, column: 1] = 60
        m[row: 1, column: 2] = 70
        m[row: 1, column: 3] = 80
        m[row: 2, column: 0] = 90
        m[row: 2, column: 1] = 100
        m[row: 2, column: 2] = 110
        m[row: 2, column: 3] = 120

        XCTAssertEqual(m.nRows, 3)
        XCTAssertEqual(m.nColumns, 4)
        XCTAssertEqual(m[row: 0, column: 0], 10)
        XCTAssertEqual(m[row: 0, column: 1], 20)
        XCTAssertEqual(m[row: 0, column: 2], 30)
        XCTAssertEqual(m[row: 0, column: 3], 40)
        XCTAssertEqual(m[row: 1, column: 0], 50)
        XCTAssertEqual(m[row: 1, column: 1], 60)
        XCTAssertEqual(m[row: 1, column: 2], 70)
        XCTAssertEqual(m[row: 1, column: 3], 80)
        XCTAssertEqual(m[row: 2, column: 0], 90)
        XCTAssertEqual(m[row: 2, column: 1], 100)
        XCTAssertEqual(m[row: 2, column: 2], 110)
        XCTAssertEqual(m[row: 2, column: 3], 120)
    }
    
    func testMatrixSliceRow() {
        var m = Matrix(nRows: 2, nColumns: 3, elements: 1, 2, 3, 4, 5, 6)
        let slice0 = m[row: 0]
        let slice1 = m[row: 1]

        XCTAssertEqual(slice0.length, 3)
        XCTAssertEqual(slice1.length, 3)

        XCTAssertEqual(m[row: 0, column: 0], 1)
        XCTAssertEqual(m[row: 0, column: 1], 2)
        XCTAssertEqual(m[row: 0, column: 2], 3)
        XCTAssertEqual(m[row: 1, column: 0], 4)
        XCTAssertEqual(m[row: 1, column: 1], 5)
        XCTAssertEqual(m[row: 1, column: 2], 6)

        XCTAssertEqual(slice0[0], 1)
        XCTAssertEqual(slice0[1], 2)
        XCTAssertEqual(slice0[2], 3)
        XCTAssertEqual(slice1[0], 4)
        XCTAssertEqual(slice1[1], 5)
        XCTAssertEqual(slice1[2], 6)

        m[row: 0] = slice1
        
        XCTAssertEqual(m[row: 0, column: 0], 4)
        XCTAssertEqual(m[row: 0, column: 1], 5)
        XCTAssertEqual(m[row: 0, column: 2], 6)
        XCTAssertEqual(m[row: 1, column: 0], 4)
        XCTAssertEqual(m[row: 1, column: 1], 5)
        XCTAssertEqual(m[row: 1, column: 2], 6)
        
        XCTAssertEqual(slice0[0], 1)
        XCTAssertEqual(slice0[1], 2)
        XCTAssertEqual(slice0[2], 3)
        XCTAssertEqual(slice1[0], 4)
        XCTAssertEqual(slice1[1], 5)
        XCTAssertEqual(slice1[2], 6)
        
        m[row: 1] = slice0
        
        XCTAssertEqual(m[row: 0, column: 0], 4)
        XCTAssertEqual(m[row: 0, column: 1], 5)
        XCTAssertEqual(m[row: 0, column: 2], 6)
        XCTAssertEqual(m[row: 1, column: 0], 1)
        XCTAssertEqual(m[row: 1, column: 1], 2)
        XCTAssertEqual(m[row: 1, column: 2], 3)
        
        XCTAssertEqual(slice0[0], 1)
        XCTAssertEqual(slice0[1], 2)
        XCTAssertEqual(slice0[2], 3)
        XCTAssertEqual(slice1[0], 4)
        XCTAssertEqual(slice1[1], 5)
        XCTAssertEqual(slice1[2], 6)
    }
    
    func testMatrixSliceColumn() {
        var m = Matrix(nRows: 3, nColumns: 2, elements: 1, 2, 3, 4, 5, 6)
        let slice0 = m[column: 0]
        let slice1 = m[column: 1]

        XCTAssertEqual(slice0.length, 3)
        XCTAssertEqual(slice1.length, 3)
        
        XCTAssertEqual(m[row: 0, column: 0], 1)
        XCTAssertEqual(m[row: 0, column: 1], 2)
        XCTAssertEqual(m[row: 1, column: 0], 3)
        XCTAssertEqual(m[row: 1, column: 1], 4)
        XCTAssertEqual(m[row: 2, column: 0], 5)
        XCTAssertEqual(m[row: 2, column: 1], 6)
        
        XCTAssertEqual(slice0[0], 1)
        XCTAssertEqual(slice0[1], 3)
        XCTAssertEqual(slice0[2], 5)
        XCTAssertEqual(slice1[0], 2)
        XCTAssertEqual(slice1[1], 4)
        XCTAssertEqual(slice1[2], 6)
        
        m[column: 0] = slice1
        
        XCTAssertEqual(m[row: 0, column: 0], 2)
        XCTAssertEqual(m[row: 0, column: 1], 2)
        XCTAssertEqual(m[row: 1, column: 0], 4)
        XCTAssertEqual(m[row: 1, column: 1], 4)
        XCTAssertEqual(m[row: 2, column: 0], 6)
        XCTAssertEqual(m[row: 2, column: 1], 6)
        
        XCTAssertEqual(slice0[0], 1)
        XCTAssertEqual(slice0[1], 3)
        XCTAssertEqual(slice0[2], 5)
        XCTAssertEqual(slice1[0], 2)
        XCTAssertEqual(slice1[1], 4)
        XCTAssertEqual(slice1[2], 6)
        
        m[column: 1] = slice0
        
        XCTAssertEqual(m[row: 0, column: 0], 2)
        XCTAssertEqual(m[row: 0, column: 1], 1)
        XCTAssertEqual(m[row: 1, column: 0], 4)
        XCTAssertEqual(m[row: 1, column: 1], 3)
        XCTAssertEqual(m[row: 2, column: 0], 6)
        XCTAssertEqual(m[row: 2, column: 1], 5)
        
        XCTAssertEqual(slice0[0], 1)
        XCTAssertEqual(slice0[1], 3)
        XCTAssertEqual(slice0[2], 5)
        XCTAssertEqual(slice1[0], 2)
        XCTAssertEqual(slice1[1], 4)
        XCTAssertEqual(slice1[2], 6)
    }
    
    func testMulRowSimple() {
        var m = Matrix(nRows: 2, nColumns: 3, elements: 1, 2, 3, 4, 5, 6)
        let a = RowVector(10, 20, 30, 40)
        let b = Matrix(nRows: 4, nColumns: 3, elements: 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12)
        
        m[row: 0] = a * b

        XCTAssertEqual(a[0], 10)
        XCTAssertEqual(a[1], 20)
        XCTAssertEqual(a[2], 30)
        XCTAssertEqual(a[3], 40)
        
        XCTAssertEqual(b[row: 0, column: 0], 1)
        XCTAssertEqual(b[row: 0, column: 1], 2)
        XCTAssertEqual(b[row: 0, column: 2], 3)
        XCTAssertEqual(b[row: 1, column: 0], 4)
        XCTAssertEqual(b[row: 1, column: 1], 5)
        XCTAssertEqual(b[row: 1, column: 2], 6)
        XCTAssertEqual(b[row: 2, column: 0], 7)
        XCTAssertEqual(b[row: 2, column: 1], 8)
        XCTAssertEqual(b[row: 2, column: 2], 9)
        XCTAssertEqual(b[row: 3, column: 0], 10)
        XCTAssertEqual(b[row: 3, column: 1], 11)
        XCTAssertEqual(b[row: 3, column: 2], 12)
        
        XCTAssertEqual(m[row: 0, column: 0], 700)
        XCTAssertEqual(m[row: 0, column: 1], 800)
        XCTAssertEqual(m[row: 0, column: 2], 900)
        XCTAssertEqual(m[row: 1, column: 0], 4)
        XCTAssertEqual(m[row: 1, column: 1], 5)
        XCTAssertEqual(m[row: 1, column: 2], 6)
    }
    
    func testMulRowComplex() {
        var m = Matrix(nRows: 2, nColumns: 3, elements: 1, 2, 3, 4, 5, 6)
        let a = RowVector(10, 20)
        
        m[row: 1] = a * m
        
        XCTAssertEqual(a[0], 10)
        XCTAssertEqual(a[1], 20)

        XCTAssertEqual(m[row: 0, column: 0], 1)
        XCTAssertEqual(m[row: 0, column: 1], 2)
        XCTAssertEqual(m[row: 0, column: 2], 3)
        XCTAssertEqual(m[row: 1, column: 0], 90)
        XCTAssertEqual(m[row: 1, column: 1], 120)
        XCTAssertEqual(m[row: 1, column: 2], 150)
    }
 
    func testMulColumnSimple() {
        var m = Matrix(nRows: 3, nColumns: 2, elements: 1, 2, 3, 4, 5, 6)
        let a = Matrix(nRows: 3, nColumns: 4, elements: 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12)
        let b = ColumnVector(10, 20, 30, 40)

        m[column: 0] = a * b
        
        XCTAssertEqual(a[row: 0, column: 0], 1)
        XCTAssertEqual(a[row: 0, column: 1], 2)
        XCTAssertEqual(a[row: 0, column: 2], 3)
        XCTAssertEqual(a[row: 0, column: 3], 4)
        XCTAssertEqual(a[row: 1, column: 0], 5)
        XCTAssertEqual(a[row: 1, column: 1], 6)
        XCTAssertEqual(a[row: 1, column: 2], 7)
        XCTAssertEqual(a[row: 1, column: 3], 8)
        XCTAssertEqual(a[row: 2, column: 0], 9)
        XCTAssertEqual(a[row: 2, column: 1], 10)
        XCTAssertEqual(a[row: 2, column: 2], 11)
        XCTAssertEqual(a[row: 2, column: 3], 12)
        
        XCTAssertEqual(b[0], 10)
        XCTAssertEqual(b[1], 20)
        XCTAssertEqual(b[2], 30)
        XCTAssertEqual(b[3], 40)
        
        XCTAssertEqual(m[row: 0, column: 0], 300)
        XCTAssertEqual(m[row: 0, column: 1], 2)
        XCTAssertEqual(m[row: 1, column: 0], 700)
        XCTAssertEqual(m[row: 1, column: 1], 4)
        XCTAssertEqual(m[row: 2, column: 0], 1100)
        XCTAssertEqual(m[row: 2, column: 1], 6)
    }
    
    func testMulColumnComplex() {
        var m = Matrix(nRows: 3, nColumns: 2, elements: 1, 2, 3, 4, 5, 6)
        let a = ColumnVector(10, 20)
        
        m[column: 1] = m * a
        
        XCTAssertEqual(a[0], 10)
        XCTAssertEqual(a[1], 20)
        
        XCTAssertEqual(m[row: 0, column: 0], 1)
        XCTAssertEqual(m[row: 0, column: 1], 50)
        XCTAssertEqual(m[row: 1, column: 0], 3)
        XCTAssertEqual(m[row: 1, column: 1], 110)
        XCTAssertEqual(m[row: 2, column: 0], 5)
        XCTAssertEqual(m[row: 2, column: 1], 170)
    }
    
}

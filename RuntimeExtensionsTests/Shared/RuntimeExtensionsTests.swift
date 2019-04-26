//
//  RuntimeExtensionsTests.swift
//  DinoDNA
//
//  Created by Brian Strobach on 4/27/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import XCTest
import SwiftTestUtils

class RuntimeExtensionsTests: BaseTestCase{

    //MARK: Linux Testing
    static var allTests = [
        ("testLinuxTestSuiteIncludesAllTests", testLinuxTestSuiteIncludesAllTests),
        ("testKVC", testKVC),
        ("testKVCStruct", testKVCStruct)
    ]

    func testLinuxTestSuiteIncludesAllTests(){
        assertLinuxTestCoverage(tests: type(of: self).allTests)
    }
    
    func testKVC(){
        let testKVCModel = TestKVCModel()
        let id: Int? = XCTAssertCast(testKVCModel["id"])
        let stringField: String = XCTAssertCast(testKVCModel["stringField"])
        let optionalStringField: String? = XCTAssertCast(testKVCModel["optionalStringField"])
        let intField: Int = XCTAssertCast(testKVCModel["intField"])
        let doubleField: Double = XCTAssertCast(testKVCModel["doubleField"])
        let booleanField: Bool = XCTAssertCast(testKVCModel["booleanField"])
        let dateField: Date = XCTAssertCast(testKVCModel["dateField"])

        XCTAssertEqual(testKVCModel.id, id)
        XCTAssertEqual(testKVCModel.stringField, stringField)
        XCTAssertEqual(testKVCModel.optionalStringField, optionalStringField)
        XCTAssertEqual(testKVCModel.intField, intField)
        XCTAssertEqual(testKVCModel.doubleField, doubleField)
        XCTAssertEqual(testKVCModel.booleanField, booleanField)
        XCTAssertEqual(testKVCModel.dateField, dateField)

        testKVCModel["id"] = Int.max
        testKVCModel["stringField"] = "New String"
        testKVCModel["optionalStringField"] = "New String"
        testKVCModel["intField"] = Int.max
        testKVCModel["doubleField"] = Double.infinity
        testKVCModel["booleanField"] = true
        testKVCModel["dateField"] = Date()

        XCTAssertNotEqual(testKVCModel.id, id)
        XCTAssertNotEqual(testKVCModel.stringField, stringField)
        XCTAssertNotEqual(testKVCModel.optionalStringField, optionalStringField)
        XCTAssertNotEqual(testKVCModel.intField, intField)
        XCTAssertNotEqual(testKVCModel.doubleField, doubleField)
        XCTAssertNotEqual(testKVCModel.booleanField, booleanField)
        XCTAssertNotEqual(testKVCModel.dateField, dateField)
    }

    func testKVCStruct(){
        var testKVCStruct = TestKVCStruct()
        let id: Int? = XCTAssertCast(testKVCStruct["id"])
        let stringField: String = XCTAssertCast(testKVCStruct["stringField"])
        let optionalStringField: String? = XCTAssertCast(testKVCStruct["optionalStringField"])
        let intField: Int = XCTAssertCast(testKVCStruct["intField"])
        let doubleField: Double = XCTAssertCast(testKVCStruct["doubleField"])
        let booleanField: Bool = XCTAssertCast(testKVCStruct["booleanField"])
        let dateField: Date = XCTAssertCast(testKVCStruct["dateField"])

        XCTAssertEqual(testKVCStruct.id, id)
        XCTAssertEqual(testKVCStruct.stringField, stringField)
        XCTAssertEqual(testKVCStruct.optionalStringField, optionalStringField)
        XCTAssertEqual(testKVCStruct.intField, intField)
        XCTAssertEqual(testKVCStruct.doubleField, doubleField)
        XCTAssertEqual(testKVCStruct.booleanField, booleanField)
        XCTAssertEqual(testKVCStruct.dateField, dateField)

        testKVCStruct["id"] = Int.max
        testKVCStruct["stringField"] = "New String"
        testKVCStruct["optionalStringField"] = "New String"
        testKVCStruct["intField"] = Int.max
        testKVCStruct["doubleField"] = Double.infinity
        testKVCStruct["booleanField"] = true
        testKVCStruct["dateField"] = Date()

        XCTAssertNotEqual(testKVCStruct.id, id)
        XCTAssertNotEqual(testKVCStruct.stringField, stringField)
        XCTAssertNotEqual(testKVCStruct.optionalStringField, optionalStringField)
        XCTAssertNotEqual(testKVCStruct.intField, intField)
        XCTAssertNotEqual(testKVCStruct.doubleField, doubleField)
        XCTAssertNotEqual(testKVCStruct.booleanField, booleanField)
        XCTAssertNotEqual(testKVCStruct.dateField, dateField)
    }
    
    
    
}



public func XCTAssertCast<T>(_ value: Any?, as type: T.Type = T.self) -> T{
    guard let casted = value as? T else {
        XCTFail("Asserted cast failed. Expected \(T.self) but got \(String(describing: value.self))")
        return value as! T //This test fails all tests early.
    }
    return casted
}

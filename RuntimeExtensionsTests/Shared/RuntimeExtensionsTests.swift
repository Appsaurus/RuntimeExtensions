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
		("testLinuxTestSuiteIncludesAllTests", testLinuxTestSuiteIncludesAllTests)
	]

	func testLinuxTestSuiteIncludesAllTests(){
		assertLinuxTestCoverage(tests: type(of: self).allTests)
	}
}

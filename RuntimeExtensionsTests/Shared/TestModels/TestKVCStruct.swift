//
//  TestKVCStruct.swift
//  RuntimeExtensionsTests
//
//  Created by Brian Strobach on 11/6/18.
//

import Foundation
import RuntimeExtensions
public struct TestKVCStruct: KVCStruct{
    public var id: Int?
    public var stringField: String = ""
    public var optionalStringField: String?
    public var intField: Int = 1
    public var doubleField: Double = 0.0
    public var booleanField: Bool = false
    public var dateField: Date = Date()    
}

//
//  GlobalRuntimeFunctions.swift
//  AnyCodable
//
//  Created by Brian Strobach on 5/18/18.
//

import Foundation
import Runtime


//MARK: Reflection
public func properties(_ instance: Any) throws -> [PropertyInfo]{
	return try properties(type(of: instance))
}

public func properties(_ type: Any.Type) throws -> [PropertyInfo]{
	let info = try typeInfo(of: type)
	return info.properties
}

public func property(for key: String, of type: Any.Type) throws -> PropertyInfo{
	let info = try typeInfo(of: type)
	return try info.property(named: key)
}
public func property(for key: String, of instance: Any) throws -> PropertyInfo{
	return try property(for: key, of: type(of: instance))
}



//MARK: String key type-erased value coding
public func get(_ key: String, from instance: Any) throws -> Any {
	return try property(for: key, of: instance).get(from: instance)
}

public func get<V>(_ key: String, from instance: Any, as: V.Type = V.self) throws -> V {
	return try property(for: key, of: instance).get(from: instance) as V
}

public func set<O>(_ value: Any, key: String, for instance: inout O) throws {
	try property(for: key, of: instance).set(value: value, on: &instance)
}

public func set(_ value: Any, key: String, for instance: inout Any) throws {
	try property(for: key, of: instance).set(value: value, on: &instance)
}

public func set(_ value: Any, key: String, for instance: Any) throws {
	var copy: Any = instance
	try set(value, key: key, for: &copy)
}

public func iterateKeyValues(of object: Any, _ closure: (String, Any) throws -> ()) throws{
	try properties(object).forEach { (property) in
		try closure(property.name, try get(property.name, from: object))
	}
}

//MARK: Batch key value updating
public func update(_ object: Any, with dictionary: Dictionary<String, Any>) throws{
	for (key, value) in dictionary{
		try set(value, key: key, for: object)
	}
}

public func update(_ object: Any, withKeyValuesOf sourceObject: Any) throws{
	for property in try properties(sourceObject){
		let key = property.name
		let value = try get(key, from: sourceObject)
		try set(value, key: key, for: object)
	}
}

//MARK: Dictionary representation
public func reflectToDictionary<O>(object: O) throws -> Dictionary<String, Any>{
	return try Dictionary<String, Any>(object)
}
extension Dictionary where Key == String, Value == Any{
	public init<O>(_ object: O) throws {
		self.init()
		try properties(object).forEach({ (property) in
			let value = try get(property.name, from: object)
			self[property.name] = value
		})
	}
}

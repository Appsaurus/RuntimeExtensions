//
//  KVC.swift
//  Pods
//
//  Created by Brian Strobach on 7/11/17.
//
//

import Runtime

/// Enables dynamic, KVC-style behavior for native Swift structures.
public protocol KVCStruct {}

extension KVCStruct {

	/// Subscript for getting and setting value properties.
	/// Handles failure silently.
	public subscript (key: String) -> Any? {
		get {
			return try? get(key: key)
		}
		set {
			_ = try? set(value: newValue as Any, key: key)
		}
	}

	/// Get value for key; may throw Runtime error.
	public func get(key: String) throws -> Any {
		return try RuntimeExtensions.get(key, from: self)
	}

	/// Set value for key; may throw Runtime error.
	public mutating func set(value: Any, key: String) throws {
		try RuntimeExtensions.set(value, key: key, for: &self)
	}

	@discardableResult
	public mutating func update(with dictionary: Dictionary<String, Any>) throws -> Self{
		for (key, value) in dictionary{
			try set(value: value, key: key)
		}
		return self
	}
	@discardableResult
	public mutating func updateWithKeyValues<M: KVC>(of model: M) throws -> Self{
		for property in try self.properties(){
			let key = property.name
			try set(value: model.get(key: key), key: key)
		}
		return self
	}

	public func properties() throws ->  [PropertyInfo]{
		return try RuntimeExtensions.properties(self)
	}

	public static func properties() throws -> [PropertyInfo]{
		return try RuntimeExtensions.properties(self)
	}

	public func reflectToDictionary() throws -> Dictionary<String, Any>{
		return try .init(self)
	}
}

/// Enables dynamic, KVC-style behavior for native Swift classes.
public protocol KVC : class {}

extension KVC {

	/// Subscript for getting and setting object properties.
	/// Handles failure silently.
	public subscript (key: String) -> Any {
		get {
			return (try? get(key: key)) as Any
		}
		set {
			_ = try? set(value: newValue, key: key)
		}
	}

	/// Get value for key; may throw Runtime error.
	public func get(key: String) throws -> Any {
		return try RuntimeExtensions.get(key, from: self)
	}

	/// Set value for key; may throw Runtime error.
	public func set(value: Any, key: String) throws {
		try RuntimeExtensions.set(value, key: key, for: self)
	}

	public func properties() throws ->  [PropertyInfo]{
		return try RuntimeExtensions.properties(self)
	}

	public static func properties() throws -> [PropertyInfo]{
		return try RuntimeExtensions.properties(self)
	}

	@discardableResult
	public func update(with dictionary: Dictionary<String, Any>) throws -> Self{
		let mutableSelf = self
		try RuntimeExtensions.update(mutableSelf, with: dictionary)
		return self
	}

	@discardableResult
	public func updateWithKeyValues<O: KVC>(of object: O) throws -> Self{
		try RuntimeExtensions.update(self, withKeyValuesOf: object)
		return self
	}

	public func reflectToDictionary() throws -> Dictionary<String, Any>{
		return try .init(self)
	}

}

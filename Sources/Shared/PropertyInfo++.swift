//
//  PropertyInfo++.swift
//  
//
//  Created by Brian Strobach on 8/27/21.
//

import Runtime

public extension PropertyInfo {
    func typeInfo() throws -> TypeInfo {
        try Runtime.typeInfo(of: type)
    }

    func kind() throws -> Kind {
        return try typeInfo().kind
    }

    func isEnum() throws -> Bool {
        try typeInfo().isEnum()
    }

    func isOptional() throws -> Bool {
        try typeInfo().isOptional()
    }

    func isArray() throws -> Bool {
        try typeInfo().isArray()
    }

    func elementTypeInfo() throws -> TypeInfo? {
        try genericTypeInfo(at: 0)
    }

    func genericTypeInfo(at index: Int) throws -> TypeInfo? {
        try typeInfo().genericTypeInfo(at: index)
    }

    func genericTypes() throws -> [Any.Type] {
        try typeInfo().genericTypes
    }

    func genericType(at index: Int) throws -> Any.Type? {
        try typeInfo().genericType(at: index)
    }
}

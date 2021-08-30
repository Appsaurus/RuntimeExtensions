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

    func genericTypeInfo(at index: Int) -> TypeInfo? {
        return try? typeInfo().genericTypeInfo(at: index)
    }

    func genericType(at index: Int) -> Any.Type? {
        return try? typeInfo().genericType(at: index)
    }

    var isArray: Bool {
        return proxy(\.isArray)
    }

    var arrayElementType: Any.Type? {
        return proxy(\.arrayElementType)
    }

    var isDictionary: Bool {
        return proxy(\.isDictionary)
    }

    var dictionaryKeyType: Any.Type? {
        return proxy(\.dictionaryKeyType)
    }

    var dictionaryKeyTypeInfo: TypeInfo? {
        return proxy(\.dictionaryKeyTypeInfo)
    }

    var dictionaryValueType: Any.Type? {
        return proxy(\.dictionaryValueType)
    }

    var dictionaryValueTypeInfo: TypeInfo? {
        return proxy(\.dictionaryValueTypeInfo)
    }

    var isEnum: Bool {
        proxy(\.isEnum)
    }

    var isOptional: Bool {
        proxy(\.isOptional)
    }

    private func proxy(_ keyPath: KeyPath<TypeInfo, Bool>) -> Bool {
        guard let isTrue = try? typeInfo()[keyPath: keyPath] else {
            return false
        }
        return isTrue
    }

    private func proxy<Value>(_ keyPath: KeyPath<TypeInfo, Value?>) -> Value? {
        return try? typeInfo()[keyPath: keyPath]
    }
}

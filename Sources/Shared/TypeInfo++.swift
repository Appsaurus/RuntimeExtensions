//
//  TypeInfo++.swift
//  
//
//  Created by Brian Strobach on 8/27/21.
//

import Runtime

public extension TypeInfo {
    func isArray() -> Bool {
        mangledName == "Array"
    }

    func elementTypeInfo() throws -> TypeInfo? {
        try genericTypeInfo(at: 0)
    }

    func isEnum() -> Bool {
        return kind == .enum
    }

    func isOptional() -> Bool {
        return kind == .optional
    }

    func genericTypeInfo(at index: Int) throws -> TypeInfo? {
        guard let genericType = try genericType(at: index) else {
            return nil
        }

        return try Runtime.typeInfo(of: genericType)
    }


    func genericType(at index: Int) throws -> Any.Type? {
        guard genericTypes.count > index else {
            return nil
        }
        return genericTypes[index]
    }
}

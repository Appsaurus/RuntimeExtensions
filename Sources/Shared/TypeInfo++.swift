//
//  TypeInfo++.swift
//  
//
//  Created by Brian Strobach on 8/27/21.
//

import Runtime

public extension TypeInfo {

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

    func isArray() -> Bool {
        mangledName == "Array"
    }

    var arrayElementType: Any.Type? {
        return isArray() ? try? genericType(at: 0) : nil
    }

    func isDictionary() -> Bool {
        mangledName == "Dictionary"
    }

    var dictionaryKeyType: Any.Type? {
        return isDictionary() ? try? genericType(at: 0) : nil
    }

    var dictionaryValueType: Any.Type? {
        return isDictionary() ? try? genericType(at: 1) : nil
    }

    func isEnum() -> Bool {
        return kind == .enum
    }

    func isOptional() -> Bool {
        return kind == .optional
    }
}

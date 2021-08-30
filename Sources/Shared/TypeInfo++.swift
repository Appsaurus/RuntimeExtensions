//
//  TypeInfo++.swift
//  
//
//  Created by Brian Strobach on 8/27/21.
//

import Runtime

public extension TypeInfo {

    func genericTypeInfo(at index: Int) -> TypeInfo? {
        return optionalTypeInfo(genericType(at: index))
    }

    func genericType(at index: Int) -> Any.Type? {
        guard genericTypes.count > index else {
            return nil
        }
        return genericTypes[index]
    }

    var isArray: Bool {
        mangledName == "Array"
    }

    var arrayElementType: Any.Type? {
        return isArray ? genericType(at: 0) : nil
    }

    var isDictionary: Bool {
        mangledName == "Dictionary"
    }

    var dictionaryKeyType: Any.Type? {
        return isDictionary ? genericType(at: 0) : nil
    }

    var dictionaryKeyTypeInfo: TypeInfo? {
        return optionalTypeInfo(dictionaryKeyType)
    }

    var dictionaryValueType: Any.Type? {
        return isDictionary ? genericType(at: 1) : nil
    }

    var dictionaryValueTypeInfo: TypeInfo? {
        return optionalTypeInfo(dictionaryValueType)
    }


    var isEnum: Bool {
        return kind == .enum
    }

    var isOptional: Bool {
        return kind == .optional
    }
}

private func optionalTypeInfo(_ type: Any.Type?) -> TypeInfo? {
    guard let type = type else {
        return nil
    }
    return try? typeInfo(of: type)
}

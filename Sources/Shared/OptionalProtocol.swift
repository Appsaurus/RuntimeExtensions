//
//  OptionalProtocol.swift
//  
//
//  Created by Brian Strobach on 8/27/21.
//

import Foundation

//Workaround for swift's lack of covariance and contravariance on Optional type
//Allows for check like '<type> is OptionalProtocol' or 'isOptional(instance)
fileprivate protocol OptionalProtocol {}

extension Optional : OptionalProtocol {}

public func isOptional(_ instance: Any) -> Bool {
    return instance is OptionalProtocol
}

public func isOptionalType(_ type: Any.Type) -> Bool {
    return type is OptionalProtocol.Type
}

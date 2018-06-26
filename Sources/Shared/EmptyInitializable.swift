//
//  EmptyInitializable.swift
//  Runtime
//
//  Created by Brian Strobach on 5/29/18.
//

import Foundation
public protocol EmptyInitializable{
	init()
}

extension EmptyInitializable{

	public func reflectedCopy() throws -> Self{
		let copy = Self.init()
		try update(copy, with: reflectToDictionary(object: self))
		return copy
	}

	public static func initArray(_ size: Int) -> [Self]{
		var items: [Self] = []
		for _ in 1...size{
			items.append(self.init())
		}
		return items
	}
}


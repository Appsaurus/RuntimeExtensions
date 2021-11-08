//
//  EnumUtils.swift
//  RuntimeExtensions
//
//  Created by Brian Strobach on 5/21/18.
//

import Foundation

open class EnumUtils{
	public static func iterateEnum<T: Hashable>(_: T.Type) -> AnyIterator<T> {
		var i = 0
		return AnyIterator {
			let next = withUnsafeBytes(of: &i) { $0.load(as: T.self) }
			if next.hashValue != i { return nil }
			i += 1
			return next
		}
	}

	public static func allCasesArray<T: Hashable>(_: T.Type) -> [T]{
		return EnumUtils.iterateEnum(T.self).map({return $0})
	}

	public static func allCasesSet<T: Hashable>(_: T.Type) -> Set<T>{
		return Set<T>(EnumUtils.iterateEnum(T.self))
	}
}


#if compiler(<4.2)
public protocol CaseIterable: Hashable {
	static var allCases: [Self] { get }
}
extension CaseIterable {
	static public var allCases: [Self] {
		typealias S = Self
		return EnumUtils.allCasesArray(S.self)
	}

	static public var casesIterator: AnyIterator<Self> {
		typealias S = Self
		return EnumUtils.iterateEnum(S.self)
	}
}
#endif

extension CaseIterable where Self: Hashable{

    static public var caseSet: Set<Self>  {
		typealias S = Self
		return Set<S>(S.allCases)
	}

}

public protocol ReflectableAssociatedEnum {
	var reflectedAssociation: (label:String, value: Any?){get}
}

public extension ReflectableAssociatedEnum {
    var reflectedAssociation: (label:String, value: Any?) {
		get {
			let mirror = Mirror(reflecting: self)
			if let associated = mirror.children.first {
				return (associated.label!, associated.value)
			}
			return ("\(self)", nil)
		}
	}
}


//Compares enums type but ignores associated values
public func == (lhs: ReflectableAssociatedEnum, rhs: ReflectableAssociatedEnum) -> Bool {
	return lhs.reflectedAssociation.label == rhs.reflectedAssociation.label
}

//Trying to figure out a way to also compare asssocated values but not sure there is a way
//func === (lhs: ReflectableAssociatedEnum, rhs: ReflectableAssociatedEnum) -> Bool {
//guard lhs.reflectedAssociation.value is Equatable && rhs.reflectedAssociation.value is Equatable else{
//print("Attempted to compare non equatable associated value enums.")
//return false
//}

//guard let object1 = lhs.reflectedAssociation.value as? AnyObject, let object2 = rhs.reflectedAssociation.value as? AnyObject else{
//print("Attempted to compare non equatable associated value enums.")
//return false
//}
//return lhs == rhs && isEqual(object1, b: object2)
//}

//func isEqual<T : Equatable>(a: T, b: T) -> Bool {
//return a == b;
//}


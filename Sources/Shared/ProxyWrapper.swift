//
//  ProxyWrapper.swift
//  
//
//  Created by Brian Strobach on 8/30/21.
//

//Original implementation: https://www.swiftbysundell.com/articles/accessing-a-swift-property-wrappers-enclosing-instance/

@propertyWrapper
struct Proxy<EnclosingType, Value> {
    typealias ValueKeyPath = ReferenceWritableKeyPath<EnclosingType, Value>
    typealias SelfKeyPath = ReferenceWritableKeyPath<EnclosingType, Self>

    static subscript(
        _enclosingInstance instance: EnclosingType,
        wrapped wrappedKeyPath: ValueKeyPath,
        storage storageKeyPath: SelfKeyPath
    ) -> Value {
        get {
    let keyPath = instance[keyPath: storageKeyPath].keyPath
    return instance[keyPath: keyPath]
}
set {
    let keyPath = instance[keyPath: storageKeyPath].keyPath
    instance[keyPath: keyPath] = newValue
}
    }

    @available(*, unavailable,
        message: "@Proxy can only be applied to classes"
    )
    var wrappedValue: Value {
        get { fatalError() }
        set { fatalError() }
    }

    private let keyPath: ValueKeyPath

    init(_ keyPath: ValueKeyPath) {
        self.keyPath = keyPath
    }
}

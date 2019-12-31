//
//  Thin.swift
//  Thin
//
//  Created by JuanFelix on 2019/12/30.
//

public struct Thin<Base> {
    public let base: Base
    public init(_ base: Base) {
        self.base = base
    }
}

public protocol ThinCompatible {
    associatedtype CompatibleType
    static var th: Thin<CompatibleType>.Type { get set }
    var th: Thin<CompatibleType> { get set }
}

extension ThinCompatible {
    public static var th: Thin<Self>.Type {
        get {
            return Thin<Self>.self
        }
        
        set { }
    }
    
    public var th: Thin<Self> {
        get {
            return Thin(self)
        }
        
        set { }
    }
}

import Foundation.NSObject

extension NSObject: ThinCompatible {}

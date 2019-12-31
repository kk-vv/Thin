//
//  UIFont+Thin.swift
//  Thin
//
//  Created by JuanFelix on 2019/12/31.
//

import Foundation

public enum FontNameType {
    case title, body
}

extension Thin where Base: UIFont {
    
    public static func font(_ type: FontNameType,
                            size: CGFloat,
                            fix: CGFloat = 0) -> UIFont {
        switch type {
            case .title:
                return title(size: size, fix: fix)
            case .body:
                return body(size: size, fix: fix)
        }
    }
    
    public static func title(size: CGFloat = ThinConfig.titleFontSize,
                             fix: CGFloat = 0) -> UIFont {
        if let name = ThinConfig.titleFontName, let font = UIFont(name: name, size: size + fix) {
            return font
        }
        return UIFont.systemFont(ofSize: size + fix)
    }
    
    public static func body(size: CGFloat = ThinConfig.bodyFontSize,
                             fix: CGFloat = 0) -> UIFont {
        if let name = ThinConfig.bodyFontName, let font = UIFont(name: name, size: size + fix) {
            return font
        }
        return UIFont.systemFont(ofSize: size + fix)
    }
    
    public static func mark(size: CGFloat = ThinConfig.markFontSize,
                             fix: CGFloat = 0) -> UIFont {
        if let name = ThinConfig.bodyFontName, let font = UIFont(name: name, size: size + fix) {
            return font
        }
        return UIFont.systemFont(ofSize: size + fix)
    }
}

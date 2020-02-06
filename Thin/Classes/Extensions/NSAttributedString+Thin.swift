//
//  NSAttributeString+Thin.swift
//  Thin
//
//  Created by JuanFelix on 2019/12/30.
//

import Foundation

public enum THAttributedLineType {
    case underLine, deleteLine
}

extension Thin where Base: NSAttributedString {
    
    /// Build Line Style Text
    /// - Parameters:
    ///   - text: -
    ///   - style: -
    ///   - range: -
    public static func lineStyle(_ text: String,
                                 style: THAttributedLineType,
                                 at range: NSRange) -> NSMutableAttributedString {
        let attrString = NSMutableAttributedString(string: text)
        switch style {
        case .deleteLine:
            attrString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: range)
        case .underLine:
            attrString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue , range: range)
        }
        return attrString
    }
    
    
    /// Build Color Text
    /// - Parameters:
    ///   - text: -
    ///   - color: -
    ///   - range: -
    public static func colorText(_ text: String,
                                 color: UIColor,
                                 at range: NSRange) -> NSMutableAttributedString {
        let attrString = NSMutableAttributedString(string: text)
        if range.length > 0 {
            attrString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        }
        return attrString
    }
    
    
    /// Build Font Text
    /// - Parameters:
    ///   - text: -
    ///   - font: -
    ///   - range: -
    public static func fontText(_ text: String,
                                font: UIFont,
                                at range: NSRange) -> NSMutableAttributedString {
        let attrString = NSMutableAttributedString(string: text)
        if range.length > 0 {
            attrString.addAttribute(NSAttributedString.Key.font, value: font, range: range)
        }
        return attrString
    }
    
    public static func string(_ string: String,
                                font: UIFont,
                                color: UIColor,
                                at range: NSRange?) -> NSMutableAttributedString {
        let range = range ?? NSRange(location: 0, length: string.count)
        let attrString = NSMutableAttributedString(string: string)
        attrString.th.setColor(color, at: range)
        attrString.th.setFont(font, at: range)
        return attrString
    }
}

extension Thin where Base: NSMutableAttributedString {
    
    public func setColor(_ color: UIColor, at range:NSRange) {
        self.base.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
    }
    
    public func setFont(_ font: UIFont, at range: NSRange) {
        self.base.addAttribute(NSAttributedString.Key.font, value: font, range: range)
    }
}

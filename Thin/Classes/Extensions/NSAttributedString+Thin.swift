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
    public static func lineSpacing(_ spacing: CGFloat = 10, font: UIFont) -> [NSAttributedString.Key: Any] {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = spacing - (font.lineHeight - font.pointSize)
        paragraphStyle.lineBreakMode = .byWordWrapping
        return [.paragraphStyle: paragraphStyle.copy()]
    }
}
extension Thin where Base: NSAttributedString {
    public static func string(string: String,
                              font: UIFont,
                              color: UIColor? = nil,
                              lineSpacing: CGFloat = 10,
                              range: NSRange? = nil) -> NSMutableAttributedString {
        let range = range ?? NSRange(location: 0, length: string.count)
        let attrString = NSMutableAttributedString(string: string, attributes: NSAttributedString.th.lineSpacing(lineSpacing, font: font))
        attrString.th.setFont(font, at: range)
        if let color = color {
            attrString.th.setColor(color, at: range)
        }
        return attrString
    }
    /// Build Line Style Text
    /// - Parameters:
    ///   - text: -
    ///   - style: -
    ///   - range: -
    public static func lineStyle(string: String,
                                 style: THAttributedLineType,
                                 font: UIFont,
                                 at range: NSRange? = nil) -> NSMutableAttributedString {
        let range = range ?? NSRange(location: 0, length: string.count)
        let attrString = self.string(string: string, font: font)
        switch style {
        case .deleteLine:
            attrString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: range)
        case .underLine:
            attrString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue , range: range)
        }
        return attrString
    }
    
    public static func string(_ string: String,
                                font: UIFont,
                                color: UIColor,
                                at range: NSRange? = nil) -> NSMutableAttributedString {
        let range = range ?? NSRange(location: 0, length: string.count)
        let attrString = NSMutableAttributedString(string: string)
        attrString.th.setColor(color, at: range)
        attrString.th.setFont(font, at: range)
        return attrString
    }
}

extension Thin where Base: NSMutableAttributedString {
    
    public func setColor(_ color: UIColor, at range: NSRange) {
        self.base.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
    }
    
    public func setFont(_ font: UIFont, at range: NSRange) {
        self.base.addAttribute(NSAttributedString.Key.font, value: font, range: range)
    }
}

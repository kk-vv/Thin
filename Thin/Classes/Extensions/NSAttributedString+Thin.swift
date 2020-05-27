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
    public static func lineSpacing(_ spacing: CGFloat = 10, font: UIFont) -> NSMutableParagraphStyle {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = spacing - (font.lineHeight - font.pointSize)
        paragraphStyle.lineBreakMode = .byWordWrapping
        return paragraphStyle
    }
}
extension Thin where Base: NSAttributedString {
    public static func string(string: String,
                              font: UIFont,
                              color: UIColor?,
                              lineSpacing: CGFloat?,
                              range: NSRange? = nil) -> NSMutableAttributedString {
        //let range = range ?? NSRange(location: 0, length: string.count)//emoji 长度不对
        let range = range ?? NSRange(location: 0, length: (string as NSString).length)
        var attrString = NSMutableAttributedString(string: string)
        if let lineSpacing = lineSpacing {
            attrString = NSMutableAttributedString(string: string, attributes: [NSAttributedString.Key.paragraphStyle: NSAttributedString.th.lineSpacing(lineSpacing, font: font)])
        }
        attrString.th.setFont(font, at: range)
        if let color = color {
            attrString.th.setColor(color, at: range)
        }        
        return attrString
    }
}

extension Thin where Base: NSMutableAttributedString {
    
    public func setLineStyle(_ style: THAttributedLineType, at range: NSRange) {
        switch style {
        case .deleteLine:
            self.base.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: range)
        case .underLine:
            self.base.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue , range: range)
        }
    }
    
    public func setColor(_ color: UIColor, at range: NSRange) {
        self.base.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
    }
    
    public func setFont(_ font: UIFont, at range: NSRange) {
        self.base.addAttribute(NSAttributedString.Key.font, value: font, range: range)
    }
}

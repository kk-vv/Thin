//
//  UIColor+Thin.swift
//  Thin
//
//  Created by JuanFelix on 2019/12/30.
//

import UIKit

extension Thin where Base: UIColor {
    
    /// RGB
    ///
    /// - Parameters:
    ///   - r: 0~255
    ///   - g: 0~255
    ///   - b: 0~255
    ///   - a: 0~1
    /// - Returns: UIColor
    public static func rgb(_ r: CGFloat,
                           _ g: CGFloat,
                           _ b: CGFloat,
                           _ a: CGFloat = 1.0) -> UIColor {
        return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
    }

    /// Color With HEX
    public static func hex(_ hex:Int32, alpha: CGFloat = 1.0) -> UIColor {
        return rgb(((CGFloat)((hex & 0xFF0000) >> 16)),
                   ((CGFloat)((hex & 0xFF00) >> 8)),
                   ((CGFloat)(hex & 0xFF)),
                   alpha)
    }
    
    /// Color With HEX String
    public static func hexStr(_ str: String) -> UIColor {
        var cString: String = str.trimmingCharacters(in: .newlines).uppercased()
        if cString.hasPrefix("0x") || cString.hasPrefix("0X") {
            cString = cString.subs(from: 2)
        }
        if (cString.hasPrefix("#")) {
            cString = cString.subs(from: 1)
        }

        if (cString.count != 6) {
            return UIColor.clear
        }
        let rString = cString.subs(to: 2)
        let gString = cString.subs(with: 2..<4)
        let bString = cString.subs(with: 4..<6)

        var r: UInt32 = 0, g: UInt32 = 0, b: UInt32 = 0;
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)

        return rgb(CGFloat(r), CGFloat(g), CGFloat(b), CGFloat(1))
    }
    
    public static var random: UIColor {        
        let r = CGFloat(arc4random_uniform(255))
        let g = CGFloat(arc4random_uniform(255))
        let b = CGFloat(arc4random_uniform(255))
        return self.rgb(r, g, b)
    }

}

extension Thin where Base: UIColor {
    
    /// 主色调-1
    public static var tint: UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.init { (trait) -> UIColor in
                if trait.userInterfaceStyle == .dark {
                    return hexStr(ThinConfig.tintColorDark)
                } else {
                    return hexStr(ThinConfig.tintColorLight)
                }
            }
        } else {
            return hexStr(ThinConfig.tintColorLight)
        }
    }
    
    /// 主色调-2
    public static var subTint: UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.init { (trait) -> UIColor in
                if trait.userInterfaceStyle == .dark {
                    return hexStr(ThinConfig.subTintColorDark)
                } else {
                    return hexStr(ThinConfig.subTintColorLight)
                }
            }
        } else {
            return hexStr(ThinConfig.subTintColorLight)
        }
    }
    
    
    /// 背景颜色
    public static var bg: UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.init { (trait) -> UIColor in
                if trait.userInterfaceStyle == .dark {
                    return hexStr(ThinConfig.backgroundColorDark)
                } else {
                    return hexStr(ThinConfig.backgroundColorLight)
                }
            }
        } else {
            return hexStr(ThinConfig.backgroundColorLight)
        }
    }
    
    /// 子视图背景颜色
    public static var subBg: UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.init { (trait) -> UIColor in
                if trait.userInterfaceStyle == .dark {
                    return hexStr(ThinConfig.subBackgroundColorDark)
                } else {
                    return hexStr(ThinConfig.subBackgroundColorLight)
                }
            }
        } else {
            return hexStr(ThinConfig.subBackgroundColorLight)
        }
    }
    
    /// 分隔线
    public static var separator: UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.init { (trait) -> UIColor in
                if trait.userInterfaceStyle == .dark {
                    return hexStr(ThinConfig.separatorColorDark)
                } else {
                    return hexStr(ThinConfig.separatorColorLight)
                }
            }
        } else {
            return hexStr(ThinConfig.separatorColorLight)
        }
    }
    
    /// 边框
    public static var border: UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.init { (trait) -> UIColor in
                if trait.userInterfaceStyle == .dark {
                    return hexStr(ThinConfig.borderColorDark)
                } else {
                    return hexStr(ThinConfig.borderColorLight)
                }
            }
        } else {
            return hexStr(ThinConfig.borderColorLight)
        }
    }
    
    /// 空白图片背景
    public static var empty: UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.init { (trait) -> UIColor in
                if trait.userInterfaceStyle == .dark {
                    return hexStr(ThinConfig.emptyColorDark)
                } else {
                    return hexStr(ThinConfig.emptyColorLight)
                }
            }
        } else {
            return hexStr(ThinConfig.emptyColorLight)
        }
    }
    
    public static var title: UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.init { (trait) -> UIColor in
                if trait.userInterfaceStyle == .dark {
                    return hexStr(ThinConfig.titleColorDark)
                } else {
                    return hexStr(ThinConfig.titleColorLight)
                }
            }
        } else {
            return hexStr(ThinConfig.titleColorLight)
        }
    }
    
    /// 默认（25，25，25）
    public static var body: UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.init { (trait) -> UIColor in
                if trait.userInterfaceStyle == .dark {
                    return hexStr(ThinConfig.bodyColorDark)
                } else {
                    return hexStr(ThinConfig.bodyColorLight)
                }
            }
        } else {
            return hexStr(ThinConfig.bodyColorLight)
        }
    }
    
    /// 默认颜色略浅于 body
    public static var subBody: UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.init { (trait) -> UIColor in
                if trait.userInterfaceStyle == .dark {
                    return hexStr(ThinConfig.subBodyColorDark)
                } else {
                    return hexStr(ThinConfig.subBodyColorLight)
                }
            }
        } else {
            return hexStr(ThinConfig.subBodyColorLight)
        }
    }
    
    public static var mark1: UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.init { (trait) -> UIColor in
                if trait.userInterfaceStyle == .dark {
                    return hexStr(ThinConfig.mark1ColorDark)
                } else {
                    return hexStr(ThinConfig.mark1ColorLight)
                }
            }
        } else {
            return hexStr(ThinConfig.mark1ColorLight)
        }
    }
    
    public static var mark2: UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.init { (trait) -> UIColor in
                if trait.userInterfaceStyle == .dark {
                    return hexStr(ThinConfig.mark2ColorDark)
                } else {
                    return hexStr(ThinConfig.mark2ColorLight)
                }
            }
        } else {
            return hexStr(ThinConfig.mark2ColorLight)
        }
    }
}

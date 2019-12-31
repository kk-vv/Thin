//
//  ThinConfigProtocol.swift
//  Thin
//
//  Created by JuanFelix on 2019/12/30.
//

import Foundation

enum ColorMode {
    case light, dark
}

protocol ThinConfigProtocol {
    static var configDic: Dictionary<String, Any>? { get set }
    static var shareInstance: Dictionary<String, Any> { get }
    static func stringValue(for key: String, defaultValue: String) -> String
    static func boolValue(for key: String, defaultValue: Bool) -> Bool
    static func fontNameValue(for key: String) -> String?
    static func fontSizeValue(for key: String, defaultSize: CGFloat) -> CGFloat
    static func colorValue(for key: String, defaultValue: String, mode: ColorMode) -> String
}

extension ThinConfigProtocol {
    
    static func stringValue(for key: String, defaultValue: String = "N/V") -> String {
        guard let stringValue = shareInstance[key] as? String else { return defaultValue }
        return stringValue
    }

    static func boolValue(for key: String, defaultValue: Bool = false) -> Bool {
        if let boolValue = shareInstance[key] as? Bool {
            return boolValue
        }
        return defaultValue
    }
    
    static func fontNameValue(for key: String) -> String? {
        if let fontName = shareInstance["fontName"] as? Dictionary<String, Any>{
             guard let fontNameValue = fontName[key] as? String else { return nil }
            return fontNameValue
        }
        return nil
    }
    
    static func fontSizeValue(for key: String, defaultSize: CGFloat) -> CGFloat {
        if let font = shareInstance["fontSize"] as? Dictionary<String, Any>,
            let dicF = font[key] as? Dictionary<String, Any> {
            switch UIDevice.th.sizeType {
                case .s4_0:
                    return dicF["s"] as! CGFloat
                case .s4_7:
                    return dicF["m"] as! CGFloat
                case .s5_5, .s5_8:
                    return dicF["l"] as! CGFloat
                case .s6_x:
                    return dicF["xl"] as! CGFloat
                case .iPad:
                    return dicF["xl"] as! CGFloat
            }
        }
        return defaultSize
    }
    
    static func colorValue(for key: String, defaultValue: String, mode: ColorMode) -> String {
        if let color = shareInstance["color"] as? Dictionary<String, Any>,
            let dicF = color[key] as? Dictionary<String, Any> {
            switch mode {
                case .light:
                    return dicF["light"] as! String
                case .dark:
                    return dicF["dark"] as! String
            }
        }
        return defaultValue
    }
    
}

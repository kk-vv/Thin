//
//  Config.swift
//  Thin
//
//  Created by JuanFelix on 2019/12/30.
//

import Foundation

public class ThinConfig: ThinConfigProtocol {
         
    static var configDic: Dictionary<String, Any>?
    
    public static var shareInstance: Dictionary<String, Any> {
        guard let config = configDic else {
            configDic = ((NSDictionary(contentsOfFile: Bundle.th.configPath)) as! Dictionary<String, Any>)
            return configDic!
        }
        return config
    }
    
    public static var version: String {
        return stringValue(for: "version", defaultValue: "N/V")
    }
    
    // MARK: - FontName
    public static var titleFontName: String? {
        return fontNameValue(for: "title")
    }
    
    public static var bodyFontName: String? {
        return fontNameValue(for: "body")
    }
    // MARK: - FontSize
    public static var titleFontSize: CGFloat {
        return fontSizeValue(for: "title", defaultSize: 17)
    }
    
    public static var bodyFontSize: CGFloat {
        return fontSizeValue(for: "body", defaultSize: 15)
    }
    
    public static var markFontSize: CGFloat {
        return fontSizeValue(for: "mark", defaultSize: 10)
    }
    // MARK: - TintColor
    public static var tintColorLight: String {
        return colorValue(for: "tint", defaultValue: "#1876FF", mode: .light)
    }
    
    public static var tintColorDark: String {
        return colorValue(for: "tint", defaultValue: "#1880FF", mode: .dark)
    }
    
    public static var subTintColorLight: String {
        return colorValue(for: "subTint", defaultValue: "#FECD00", mode: .light)
    }
    
    public static var subTintColorDark: String {
        return colorValue(for: "subTint", defaultValue: "#FED700", mode: .dark)
    }
    
    // MARK: - BackgroundColor
    public static var backgroundColorLight: String {
        return colorValue(for: "background", defaultValue: "#FDFDFD", mode: .light)
    }
    
    public static var backgroundColorDark: String {
        return colorValue(for: "background", defaultValue: "#000000", mode: .dark)
    }
    
    public static var subBackgroundColorLight: String {
        return colorValue(for: "subBackground", defaultValue: "#FFFFFF", mode: .light)
    }
    
    public static var subBackgroundColorDark: String {
        return colorValue(for: "subBackground", defaultValue: "#1C1C1E", mode: .dark)
    }
    
    // MARK: - SeparatorColor
    public static var separatorColorLight: String {
        return colorValue(for: "separator", defaultValue: "#E5E5EA", mode: .light)
    }
    
    public static var separatorColorDark: String {
        return colorValue(for: "separator", defaultValue: "#2C2C2E", mode: .dark)
    }
    
    public static var borderColorLight: String {
        return colorValue(for: "background", defaultValue: "#D1D1D6", mode: .light)
    }
    
    public static var borderColorDark: String {
        return colorValue(for: "background", defaultValue: "#2C2C2E", mode: .dark)
    }
    
    public static var emptyColorLight: String {
        return colorValue(for: "empty", defaultValue: "#E5E5EA", mode: .light)
    }
    
    public static var emptyColorDark: String {
        return colorValue(for: "empty", defaultValue: "#2C2C2E", mode: .dark)
    }
    
    
    // MARK: - TextColor
    public static var titleColorLight: String {
        return colorValue(for: "title", defaultValue: "#020202", mode: .light)
    }
    
    public static var titleColorDark: String {
        return colorValue(for: "title", defaultValue: "#FFFFFF", mode: .dark)
    }
    
    public static var bodyColorLight: String {
        return colorValue(for: "body", defaultValue: "#181818", mode: .light)
    }
    
    public static var bodyColorDark: String {
        return colorValue(for: "body", defaultValue: "#FBFBFB", mode: .dark)
    }
    
    public static var subBodyColorLight: String {
        return colorValue(for: "subBody", defaultValue: "#232323", mode: .light)
    }
    
    public static var subBodyColorDark: String {
        return colorValue(for: "subBody", defaultValue: "#F8F8F8", mode: .dark)
    }
    
    public static var mark1ColorLight: String {
        return colorValue(for: "mark1", defaultValue: "#8C8C91", mode: .light)
    }
    
    public static var mark1ColorDark: String {
        return colorValue(for: "mark1", defaultValue: "#747579", mode: .dark)
    }
    
    public static var mark2ColorLight: String {
        return colorValue(for: "mark2", defaultValue: "#F2F2F7", mode: .light)
    }
    
    public static var mark2ColorDark: String {
        return colorValue(for: "mark2", defaultValue: "#F2F2F7", mode: .dark)
    }
}

//
//  Bundle+Thin.swift
//  Thin
//
//  Created by JuanFelix on 2019/12/30.
//

import Foundation

extension Thin where Base: Bundle {
    
    /// settings..bundle
    public static var settingBundle: Bundle {
        guard let path = Bundle(for: ThinConfig.self).path(forResource: "Settings", ofType: "bundle"), let bundle = Bundle.init(path: path) else {
            fatalError("Thin settings.bundle is missing!")
        }
        return bundle
    }
    
    
    /// config.plist
    public static var configPath: String {
        guard let path = settingBundle.path(forResource: "Configs/Config", ofType: "plist") else {
            fatalError("Thin config.plist is missing!")
        }
        return path
    }
    
    ///NavBackImageName
    public static var navBackImageName: String? {
        let scale = Int(UIScreen.main.scale)
        return settingBundle.path(forResource: "zx_navback@\(scale)x", ofType: "png")
    }
}

extension Thin where  Base: Bundle {
    /// ProjectName
    public static var projectName: String {
        return (Bundle.main.infoDictionary?["CFBundleExecutable"] as? String) ?? "N/V"
    }
    
    /// Version
    public static var version: String {
        return (Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String) ?? "N/V"
    }
    
    /// Build
    public static var build: String {
        return (Bundle.main.infoDictionary?["CFBundleVersion"] as? String) ?? "N/V"
    }
    
    /// BundleId
    public static var bundleId: String {
        return (Bundle.main.infoDictionary?["CFBundleIdentifier"] as? String) ?? "N/V"
    }
}

extension Thin where Base: UIImage {
    public static var navBackImage: UIImage? {
        if let name = Bundle.th.navBackImageName {
            return UIImage(contentsOfFile: name)
        }
        return nil
    }
}

//
//  UIDevice+Thin.swift
//  Thin
//
//  Created by JuanFelix on 2019/12/30.
//

import UIKit

public enum DeviceSizeType: CustomStringConvertible {
    public var description: String {
        switch self {
        case .s4_0:
            return "<= 4.0"
        case .s4_7:
            return "4.7(iPhone 6/7/8)"
        case .s5_5:
            return "5.5(iPhone 6P/7P/8P)"
        case .s5_8:
            return "5.8(iPhone X/XS)"
        case .s6_x:
            return "6.1/6.5(iPhone XR/XS Max)"
        case .iPad:
            return "iPad"
        }
    }
    case s4_0, s4_7, s5_5, s5_8, s6_x, iPad
}

extension Thin where Base: UIDevice {
    public static var isPhone: Bool {
        return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.phone)
    }
    
    public static var isPad: Bool {
        return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad)
    }
    
    public static var sizeType: DeviceSizeType {
        if self.isPhone {
            let length = max(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height)
            if length <= 568.0 {
                return .s4_0
            } else if length <= 667 {
                return .s4_7
            } else if length <= 812 {
                return .s5_8
            } else if length <= 896 {
                return .s6_x
            } else {
                return .s6_x
            }
        } else {
            return .iPad
        }
    }
    
    public static var isXSeries: Bool {
        if UIDevice.current.userInterfaceIdiom != UIUserInterfaceIdiom.phone {
            return false
        }
        if #available(iOS 11.0, *) {
            guard let delegate = UIApplication.shared.delegate, let window = delegate.window as? UIWindow else {
                return false
            }
            if window.safeAreaInsets.bottom > CGFloat(0) {
                return true
            }
        }
        
        return false
    }
    
    public static var topBarHeight: CGFloat {
        if isXSeries {
            return 88
        }
        return 64
    }
    
    public static var bottomBarHeight: CGFloat {
        if isXSeries {
            return 49 + 34
        }
        return 49
    }
}

extension Thin where Base: UIScreen {
    public static var width: CGFloat {
        return UIScreen.main.bounds.size.width
    }
    
    public static var height: CGFloat {
        return UIScreen.main.bounds.size.height
    }
}

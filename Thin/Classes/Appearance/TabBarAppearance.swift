//
//  TabbarAppearance.swift
//  Thin
//
//  Created by JuanFelix on 2019/12/30.
//

import Foundation

public struct TabBarBuilder {
    public static let `default` = TabBarBuilder()
    public static let dark = TabBarBuilder(isTranslucent: false,
                                           backgroundColor: UIColor.th.rgb(18, 20, 18),
                                           selectedColor: UIColor.blue,
                                           normalColor: UIColor.lightGray,
                                           font: nil,
                                           showSeparator: true)
    public var isTranslucent = false
    public var backgroundColor: UIColor = UIColor.white    //barTintColor
    public var selectedColor: UIColor = UIColor.black   //tintColor
    public var normalColor: UIColor = UIColor.lightGray
    public var font: UIFont?
    public var showSeparator = true
}

public struct TabBarAppearance {
    
    /// Active Custom Appearance
    /// - Parameters:
    ///   - builder: TabBarBuilder
    ///   - tabBar: if iOS 13 or later , need This!
    public static func active(_ builder: TabBarBuilder = TabBarBuilder.default,
                              tabBar: UITabBar? = nil) {
        let appearance = UITabBar.appearance()
        appearance.isTranslucent  = builder.isTranslucent
        appearance.barTintColor   = builder.backgroundColor
        appearance.tintColor      = builder.selectedColor
        if !builder.showSeparator {
            if #available(iOS 13.0, *) {
                if let tabBar = tabBar {
                    let appearance = tabBar.standardAppearance.copy()
                    appearance.shadowImage = UIImage.th.image(color: .clear)
                    appearance.backgroundImage = UIImage.th.image(color: .clear)
                    tabBar.standardAppearance = appearance
                }
            } else {
                appearance.shadowImage = UIImage()
                appearance.backgroundImage = UIImage()
            }
        }
        
        let tabBarItem = UITabBarItem.appearance()
        if let font = builder.font {
            tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: builder.normalColor,
                                               NSAttributedString.Key.font: font],
                                              for: .normal)
            tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: builder.selectedColor,
                                               NSAttributedString.Key.font: font],
                                              for: .selected)
        } else {
            tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: builder.normalColor], for: .normal)
            tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: builder.selectedColor], for: .selected)
        }

    }
}

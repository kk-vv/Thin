//
//  NavbarAppearance.swift
//  Thin
//
//  Created by JuanFelix on 2019/12/30.
//

import Foundation

public struct NavBarBuilder {
    public static let `default` = NavBarBuilder()
    public static let dark = NavBarBuilder.init(isTranslucent: false,
                                                backgroundColor: UIColor.th.rgb(18, 20, 18),
                                                buttonTextColor: UIColor.white,
                                                titleColor: UIColor.white,
                                                titleFont: UIFont.th.title(),
                                                showSeparator: true,
                                                useSystemBackButton: false)
    public var isTranslucent = false
    public var backgroundColor: UIColor = UIColor.white     //barTintColor
    public var buttonTextColor: UIColor = UIColor.black     //tintColor
    public var titleColor: UIColor = UIColor.black
    public var titleFont: UIFont = UIFont.systemFont(ofSize: 18)
    public var showSeparator = false
    public var useSystemBackButton = false
}

public struct NavBarAppearance {
    public static func active(_ builder: NavBarBuilder = NavBarBuilder.default) {
         let appearance = UINavigationBar.appearance()
        appearance.isTranslucent = builder.isTranslucent
        appearance.barTintColor = builder.backgroundColor
        appearance.tintColor = builder.buttonTextColor
        
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: builder.titleColor,
                                          NSAttributedString.Key.font: builder.titleFont]
        
        if !builder.showSeparator {
            appearance.shadowImage = UIImage()
            appearance.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        }
        
        if !builder.useSystemBackButton {
            guard let backImage = UIImage.th.navBackImage else {
                assertionFailure("plist navBack Image is null...")
                return
            }
            appearance.backIndicatorImage = backImage
            appearance.backIndicatorTransitionMaskImage = backImage
        }
    }

}

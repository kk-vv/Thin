//
//  UIViewController+Thin.swift
//  Thin
//
//  Created by JuanFelix on 2019/12/30.
//

import Foundation

import UIKit

extension Thin where Base: UIViewController {
    
    /// AddKeyboardNotification
    public func addKeyboardNotification() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(base, selector: #selector(base.baseKeyboardWillShow(notice:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCenter.addObserver(base, selector: #selector(base.baseKeyboardWillHide(notice:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(base, selector: #selector(base.baseKeyboardWillChangeFrame(notice:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    /// RemoveKeyboardNotification
    public func removeKeyboardNotification() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(base, name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCenter.removeObserver(base, name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.removeObserver(base, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    /// KeyWindow rootViewController
    public static var topMost: UIViewController? {
        //var keyVC = UIApplication.shared.keyWindow?.rootViewController
        let currentWindows = UIApplication.shared.windows
        var keyVC: UIViewController?
        for window in currentWindows {
          if let windowRootViewController = window.rootViewController, window.isKeyWindow {
            keyVC = windowRootViewController
            break
          }
        }

        repeat{
            if let presentedVC = keyVC?.presentedViewController {
                keyVC = presentedVC
            } else {
                break
            }
        } while ((keyVC?.presentedViewController) != nil)
        return keyVC
    }
    
    /// Add Application Notice
    public func addApplicationNotification() {
        let notificationCenter = NotificationCenter.default
        
        notificationCenter.addObserver(base, selector: #selector(base.appWillResignActive(notice:)), name: UIApplication.willResignActiveNotification, object: nil)
        notificationCenter.addObserver(base, selector: #selector(base.appDidBecomeActive(notice:)), name: UIApplication.didBecomeActiveNotification, object: nil)

        notificationCenter.addObserver(base, selector: #selector(base.appWillEnterForeground(notice:)), name: UIApplication.willEnterForegroundNotification, object: nil)
        notificationCenter.addObserver(base, selector: #selector(base.appDidEnterBackground(notice:)), name: UIApplication.didEnterBackgroundNotification, object: nil)
        
        notificationCenter.addObserver(base, selector: #selector(base.appWillTerminate(notice:)), name: UIApplication.willTerminateNotification, object: nil)
    }
    
    public func removeApplicationNotification() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(base, name: UIApplication.willResignActiveNotification, object: nil)
        notificationCenter.removeObserver(base, name: UIApplication.didBecomeActiveNotification, object: nil)
        notificationCenter.removeObserver(base, name: UIApplication.willEnterForegroundNotification, object: nil)
        notificationCenter.removeObserver(base, name: UIApplication.didEnterBackgroundNotification, object: nil)
        notificationCenter.removeObserver(base, name: UIApplication.willTerminateNotification, object: nil)
    }
}

extension UIViewController{
    
    @objc open func appWillResignActive(notice: Notification) {}
    @objc open func appDidBecomeActive(notice: Notification) {}
    @objc open func appWillEnterForeground(notice: Notification) {}
    @objc open func appDidEnterBackground(notice: Notification) {}
    @objc open func appWillTerminate(notice: Notification) {}
    
    /// keyboardWillShow
    ///
    /// - Parameters:
    ///   - dt: duration
    ///   - userInfo: userInfo description
    @objc open func keyboardWillShow(duration dt: Double,userInfo:Dictionary<String,Any>) {}
    
    /// keyboardWillHide
    ///
    /// - Parameters:
    ///   - dt: duration
    ///   - userInfo: userInfo description
    @objc open func keyboardWillHide(duration dt: Double,userInfo:Dictionary<String,Any>) {}
    
    /// keyboardWillChangeFrame
    ///
    /// - Parameters:
    ///   - beginRect: beginRect
    ///   - endRect: endRect
    ///   - dt: duration
    ///   - userInfo: userInfo description
    @objc open func keyboardWillChangeFrame(beginRect:CGRect,
                                               endRect: CGRect,
                                               duration dt:Double,
                                               userInfo:Dictionary<String,Any>) {}
    
    
    @objc final func baseKeyboardWillShow(notice:Notification) {
        if let userInfo = notice.userInfo as? Dictionary<String, Any> {
            let dt = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
            keyboardWillShow(duration: dt, userInfo:userInfo )
        }
    }
    
    @objc final func baseKeyboardWillHide(notice:Notification) {
        if let userInfo = notice.userInfo as? Dictionary<String, Any> {
            let dt = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
            keyboardWillHide(duration: dt, userInfo: userInfo)
        }
    }
    
    @objc final func baseKeyboardWillChangeFrame(notice:Notification) {
        if let userInfo = notice.userInfo as? Dictionary<String, Any> {
            let beginRect   = userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! CGRect
            let endRect     = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
            let dt          = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
            keyboardWillChangeFrame(beginRect: beginRect, endRect: endRect, duration: dt, userInfo: userInfo)
        }
    }

}

//MARK: - NavControl

public enum NavBarButtonPosition {
    case left, right
}


//MARK: - Navigation Control
extension Thin where Base: UIViewController {  
    /// Clear backBarButtonItem Title
    ///
    /// - Parameter replaceBackItem: if false , replace the leftBarButtonItem else replace backBarButtonItem
    // if true , interactivePopGestureRecognizer will disable
    public func clearNavBarBackButtonTitle(replaceBackItem: Bool = false) {
        if replaceBackItem {
            let backItem = UIBarButtonItem(title: " ", style: .done, target: base, action: #selector(base.navbackAction))
            base.navigationItem.backBarButtonItem = backItem
        } else {
            let backItem = UIBarButtonItem(image: UIImage.th.navBackImage, style: .done, target: base, action: #selector(base.navbackAction))
            base.navigationItem.leftBarButtonItem = backItem
        }
    }
    
    public func removeNavBarButton(at position: NavBarButtonPosition) {
        if position == .left {
            base.navigationItem.leftBarButtonItems = nil
        } else {
            base.navigationItem.rightBarButtonItems = nil
        }
    }
    
    /// Add BarButton Item from Image names
    public func addNavBarButton(images names: Array<String>,
                                at position: NavBarButtonPosition,
                                useOriginalColor: Bool = true,
                                fixSpace: CGFloat = 0) {
        if names.count > 0 {
            var items: Array<UIBarButtonItem> = Array()
            var n = 0
            for imgName in names {
                if names.count > 1 {
                    let negativeSpacer = UIBarButtonItem.init(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
                    negativeSpacer.width = fixSpace
                    items.append(negativeSpacer)
                }
                
                var itemT:UIBarButtonItem!
                var image = UIImage.init(named: imgName)
                if useOriginalColor {
                    image = image?.withRenderingMode(.alwaysOriginal)
                }
                if position == .right {
                    itemT = UIBarButtonItem.init(image: image, style: .plain, target: base, action: #selector(base.xxx_rightBarButtonAction(sender:)))
                } else {
                    itemT = UIBarButtonItem.init(image: image, style: .plain, target: base, action: #selector(base.xxx_leftBarButtonAction(sender:)))
                }
                itemT.tag = n
                n += 1
                items.append(itemT)
            }
            if position == .left {
                base.navigationItem.leftBarButtonItems = items
            } else {
                base.navigationItem.rightBarButtonItems = items
            }
        } else {
            if position == .left {
                base.navigationItem.leftBarButtonItems = nil
            } else {
                base.navigationItem.rightBarButtonItems = nil
            }
        }
    }
    
    
    /// Add BarButton Item by texts
    public func addNavBarButton(texts names: Array<String>,
                                at position: NavBarButtonPosition,
                                font: UIFont = UIFont.systemFont(ofSize: 14),
                                color: UIColor = UIColor.th.title,
                                fixSpace:CGFloat = 0) {
        if names.count > 0 {
            var items: Array<UIBarButtonItem> = Array()
            var n = 0
            for title in names {
                if names.count > 1 {
                    let negativeSpacer = UIBarButtonItem.init(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
                    negativeSpacer.width = fixSpace
                    items.append(negativeSpacer)
                }
                var itemT:UIBarButtonItem!
                if position == .right {
                    itemT = UIBarButtonItem.init(title: title, style: .plain, target: base, action: #selector(base.xxx_rightBarButtonAction(sender:)))
                } else {
                    itemT = UIBarButtonItem.init(title: title, style: .plain, target: base, action: #selector(base.xxx_leftBarButtonAction(sender:)))
                }
                itemT.tag = n
                n += 1
                let config = [NSAttributedString.Key.font: font,
                              NSAttributedString.Key.foregroundColor: color]
                itemT.setTitleTextAttributes(config as [NSAttributedString.Key : Any] , for: .normal)
                itemT.setTitleTextAttributes(config as [NSAttributedString.Key : Any] , for: .highlighted)
                if #available(iOS 9.0, *) {
                    itemT.setTitleTextAttributes(config as [NSAttributedString.Key : Any] , for: .focused)
                } else {
                    // Fallback on earlier versions
                    itemT.setTitleTextAttributes(config as [NSAttributedString.Key : Any] , for: .selected)
                }

                items.append(itemT)
                
            }
            if position == .left {
                base.navigationItem.leftBarButtonItems = items
            } else {
                base.navigationItem.rightBarButtonItems = items
            }
        } else {
            if position == .left {
                base.navigationItem.leftBarButtonItems = nil
            } else {
                base.navigationItem.rightBarButtonItems = nil
            }
        }
    }
    
    
    /// Add BarButton Item by iconfont Unicode Text
    public func addNavBarButton(iconFontTexts names: Array<String>,
                                at position: NavBarButtonPosition,
                                iconFont: UIFont,
                                color: UIColor = UIColor.th.title,
                                fixSpace: CGFloat = 0) {
        if names.count > 0 {
            var items: Array<UIBarButtonItem> = Array()
            var n = 0
            for title in names {
                if names.count > 1 {
                    let negativeSpacer = UIBarButtonItem.init(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
                    negativeSpacer.width = fixSpace
                    items.append(negativeSpacer)
                }
                
                var itemT:UIBarButtonItem!
                if position == .right {
                    itemT = UIBarButtonItem.init(title: title, style: .plain, target: base, action: #selector(base.xxx_rightBarButtonAction(sender:)))
                } else {
                    itemT = UIBarButtonItem.init(title: title, style: .plain, target: base, action: #selector(base.xxx_leftBarButtonAction(sender:)))
                }
                let config = [NSAttributedString.Key.font: iconFont,
                              NSAttributedString.Key.foregroundColor: color]
                itemT.setTitleTextAttributes(config as [NSAttributedString.Key : Any] , for: .normal)
                itemT.setTitleTextAttributes(config as [NSAttributedString.Key : Any] , for: .highlighted)
                if #available(iOS 9.0, *) {
                    itemT.setTitleTextAttributes(config as [NSAttributedString.Key : Any] , for: .focused)
                } else {
                    // Fallback on earlier versions
                    itemT.setTitleTextAttributes(config as [NSAttributedString.Key : Any] , for: .selected)
                }

                itemT.tag = n
                n += 1
                items.append(itemT)
            }
            if position == .left {
                base.navigationItem.leftBarButtonItems = items
            } else {
                base.navigationItem.rightBarButtonItems = items
            }
        } else {
            if position == .left {
                base.navigationItem.leftBarButtonItems = nil
            } else {
                base.navigationItem.rightBarButtonItems = nil
            }
        }
    }
    
    /// Add BarButton Item with custom view
    ///
    /// - Parameters:
    ///   - view: view
    ///   - position: left / right
    ///   - fixSpace: 0
    public func addNavBarButtonItems(customView view: UIView!,
                                     at position: NavBarButtonPosition,
                                     fixSpace: CGFloat = 0) {
        var items: Array<UIBarButtonItem> = Array()
        let negativeSpacer = UIBarButtonItem.init(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        negativeSpacer.width = fixSpace
        items.append(negativeSpacer)
        
        let itemT = UIBarButtonItem.init(customView: view)
        items.append(itemT)
        
        if position == .left {
            base.navigationItem.leftBarButtonItems = items
        } else {
            base.navigationItem.rightBarButtonItems = items
        }
    }
    
    
    /// Change NavBar BackgroundColor
    ///
    /// - Parameter color: color
    public func setNavBarBackgroundColor(_ color: UIColor!) {
        base.navigationController?.navigationBar.barTintColor = color
        if color == UIColor.clear {
            base.navigationController?.navigationBar.isTranslucent = true
            base.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .compact)
        } else {
            base.navigationController?.navigationBar.isTranslucent = false
        }
    }
    
    /// Change TabBar BackgroundColor
    ///
    /// - Parameter color: color
    public func setTabBarBackgroundColor(_ color:UIColor!) {
        base.tabBarController?.tabBar.barTintColor = color
        if color == UIColor.clear {
            base.tabBarController?.tabBar.isTranslucent = true
            base.tabBarController?.tabBar.backgroundImage = UIImage()
        } else {
            base.tabBarController?.tabBar.isTranslucent = false
        }
    }
    
    /// setNavSubViewColor: title and button color
    /// - Parameter color: color
    public func setNavSubViewColor(color: UIColor) {
        self.setNavTitleColor(color: color)
        self.setNavButtonColor(color: color)
    }
    
    /// reloadNavSubViewColor to default config [title and button color]
    public func reloadNavSubViewColor() {
        self.reloadNavTitleColor()
        self.reloadNavButtonColor()
    }
    
    private func setNavTitleColor(color: UIColor) {
        self.base.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: color]
    }
    
    private func reloadNavTitleColor() {
        self.base.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: NavBarBuilder.default.titleColor]
    }
    
    private func setNavButtonColor(color: UIColor) {
        self.base.navigationController?.navigationBar.tintColor = color
    }
    
    private func reloadNavButtonColor() {
        self.base.navigationController?.navigationBar.tintColor = NavBarBuilder.default.buttonTextColor
    }
}

extension UIViewController {
    @objc func navbackAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    /// Right BarButton Action
    ///
    /// - Parameter index if item count > 0: index 0...
    @objc open func rightBarButtonAction(index: Int) {
        
    }
    
    /// Left BarButton Action
    ///
    /// - Parameter index if item count > 0 : index 0...
    @objc open func leftBarButtonAction(index: Int) {
        
    }
    
    @objc final func xxx_rightBarButtonAction(sender:UIBarButtonItem) {
        rightBarButtonAction(index: sender.tag)
    }
    
    @objc final func xxx_leftBarButtonAction(sender:UIBarButtonItem) {
        leftBarButtonAction(index: sender.tag)
    }
}

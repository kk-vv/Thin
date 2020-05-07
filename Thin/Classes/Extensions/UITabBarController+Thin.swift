//
//  UITabBarController+Thin.swift
//  Thin
//
//  Created by JuanFelix on 2019/12/30.
//

import Foundation

class THViewController: UIViewController {
    override var shouldAutorotate: Bool { return false }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask { return .portrait }
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation { return .portrait}
}

extension NSObject {
    public var th_className: String {
        return String(describing: type(of: self))
    }
}

@objcMembers
public class TabbarItemModel: NSObject {
    public var embedInNavigation:  Bool    = true
    public var showAsPresent:      Bool    = false
    public var normalImage:        String  = ""
    public var selectedImage:      String  = ""
    public var title:              String  = ""
    
    public override init() {
    }
    
    public init(_ dic: [String:Any]!) {
        super.init()
        self.setValuesForKeys(dic)
    }
    
    override public func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}



public class THPresentVCInfo: NSObject {
    public static var thPresentVCsDic:Dictionary<String, THPresentVCInfo> = [:]
    public var className: String! = NSStringFromClass(UIViewController.self)
    public var barItem: TabbarItemModel! = nil
}

extension Thin where Base: UITabBarController {    
    
     /// AddChildViewController from ZXTabbarItem
     ///
     /// - Parameters:
     ///   - controller: controller
     ///   - item: TabbarItemModel
     ///   - imageAsTemplate: default false, if true ,use tabbar tint selectedColor after selected
     public func addChild(_ controller: UIViewController!,
                          model: TabbarItemModel,
                          imageAsTemplate: Bool = false) {
        var normalImage: UIImage?
        var selectedImage: UIImage?
        if imageAsTemplate {
            var image = UIImage(named: model.normalImage)
            image = image?.withRenderingMode(.alwaysTemplate)
            normalImage = image
            selectedImage = image

        } else {
            normalImage = UIImage.init(named: model.normalImage)
            normalImage = normalImage?.withRenderingMode(.alwaysOriginal)
            
            selectedImage = UIImage.init(named: model.selectedImage)
            selectedImage = selectedImage?.withRenderingMode(.alwaysOriginal)
        }
        
        controller.tabBarItem.image = normalImage
        controller.tabBarItem.selectedImage = selectedImage
        controller.tabBarItem.title = model.title
        
        if model.showAsPresent {
            let mInfo = THPresentVCInfo.init()
            mInfo.className =  controller.th_className
            mInfo.barItem = model
            THPresentVCInfo.thPresentVCsDic["\((base.viewControllers?.count)!)"] = mInfo
            let emptyVC = THViewController()
            emptyVC.tabBarItem.image = normalImage
            emptyVC.tabBarItem.selectedImage = normalImage
            emptyVC.tabBarItem.title = model.title
            self.base.addChild(emptyVC)
        } else {
            if model.embedInNavigation,!controller.isKind(of: UINavigationController.self) {
                let nav = UINavigationController.init(rootViewController: controller)
                nav.tabBarItem.title = model.title
                self.base.addChild(nav)
            } else {
                self.base.addChild(controller)
            }
        }
    }
    
    /// If has present show vc in plist , return this in tabBarController shouldSelectViewController
    ///
    /// - Parameters:
    ///   - tabBarController: tabBarController description
    ///   - viewController: viewController description
    /// - Returns: true/false
    public static func tabBarController(_ tabBarController:UITabBarController,
                                        shouldSelectViewController viewController:UIViewController!) -> Bool {
        
        guard let viewcontrollers = tabBarController.viewControllers,
            let index = viewcontrollers.firstIndex(of: viewController) else { return false }
        
        guard let info = THPresentVCInfo.thPresentVCsDic["\(index)"]  else {
            return true
        }
        if info.barItem.showAsPresent {
            var vcClass = NSClassFromString(info.className) as? UIViewController.Type
            if vcClass == nil {
                let className = Bundle.th.projectName + "." + info.className
                vcClass = NSClassFromString(className) as? UIViewController.Type
            }
            if let vcClass = vcClass {
                let vc = vcClass.init()
                if info.barItem.embedInNavigation,!vc.isKind(of: UINavigationController.self) {
                    tabBarController.present(UINavigationController.init(rootViewController: vc), animated: true, completion: nil)
                } else {
                    tabBarController.present(vc, animated: true, completion: nil)
                }
                return false
            }
        }
        return true
    }
}

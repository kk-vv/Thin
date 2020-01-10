//
//  AppDelegate.swift
//  Thin
//
//  Created by iFallen on 12/30/2019.
//  Copyright (c) 2019 iFallen. All rights reserved.
//

import UIKit
import ThinX

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
   
    public var titleFont: UIFont = UIFont.systemFont(ofSize: 18)
    public var useSystemBackButton = false

    
    internal func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        print(ThinConfig.version)
        var navBuilder = NavBarBuilder.default
        navBuilder.backgroundColor = UIColor.th.rgb(39, 168, 242)
        navBuilder.buttonTextColor = UIColor.th.rgb(252, 30, 112)
        navBuilder.titleColor = .red
        navBuilder.titleFont = UIFont(name: "Copperplate", size: 18)!
        navBuilder.isTranslucent = false
        navBuilder.showSeparator = false
        NavBarAppearance.active(navBuilder)
        
        var tabBuilder = TabBarBuilder.default
        tabBuilder.backgroundColor = UIColor.th.rgb(39, 40, 34)
        tabBuilder.selectedColor = UIColor.th.rgb(230, 220, 109)
        tabBuilder.normalColor = .cyan
        tabBuilder.font = UIFont(name: "Bradley Hand", size: 12)
        tabBuilder.isTranslucent = false
        tabBuilder.showSeparator = false
        TabBarAppearance.active(tabBuilder)
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}


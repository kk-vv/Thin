//
//  ViewController2.swift
//  Thin_Example
//
//  Created by JuanFelix on 2019/12/31.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import Thin

class ViewController2: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        th.addNavBarButton(texts: ["Logout"], at: .left, font: UIFont(name: "Bradley Hand", size: 16)!, color: .purple)
        th.addNavBarButton(texts: ["REQUEST", "2", "3"], at: .right, fixSpace: 20)
        
        let s = Date.th.Current.millisecond()
        print("🐌 \(s)")
        print("🐌 \(Date.th.Millisecond.intToTime(312, component: "~"))")
        print("🐌 \(Date.th.Millisecond.date(from: s))")
    }
    
    
    override func leftBarButtonAction(index: Int) {
        UIAlertController.th.showActionSheet(withTitle: "Title",
                                             message: "Message",
                                             buttonTexts: ["OK"],
                                             cancelText: "Cancel",
                                             action: { (index) in
                                                 print("🐌 button index: \(index)")
                                             },
                                             cancel: nil)
    }
    
    override func rightBarButtonAction(index: Int) {
        if index == 0 {
            ThinNetwork.async(url: "https://www.baidu.com", params: nil, method: .GET, completion: { (obj, str) in
                print("🐌 \(str ?? "")")
            }, timeOut: { (msg) in
                print("🐌 \(msg)")
            }) { (code, msg) in
                print("🐌 \(msg)")
            }
        } else {
            UIAlertController.th.showAlert(withTitle: "Index", message: "\(index)")
        }
        
    }
    
}

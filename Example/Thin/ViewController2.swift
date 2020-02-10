//
//  ViewController2.swift
//  Thin_Example
//
//  Created by JuanFelix on 2019/12/31.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import ThinX

class ViewController2: UIViewController {

    private let cView = UIView()
    private let btnShow = UIButton(type: .custom)
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        th.addNavBarButton(texts: ["Logout"], at: .left, font: UIFont(name: "Bradley Hand", size: 16)!, color: .purple)
        th.addNavBarButton(texts: ["REQUEST", "HideMask", "Alert"], at: .right, fixSpace: 20)
        
        let s = Date.th.Current.millisecond()
        print("🐌 \(s)")
        print("🐌 \(Date.th.Millisecond.intToTime(312, component: "~"))")
        print("🐌 \(Date.th.Millisecond.date(from: s))")
        
        cView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        cView.backgroundColor = UIColor.th.subTint
        cView.center = view.center
        view.addSubview(cView)
        cView.th.corners(UIRectCorner.th.forwardSlash, radii: 20, bounds: nil)
        
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
        label.text = "TEXT"
        label.textColor = UIColor.th.tint
        label.font = UIFont.th.pfFont(.semibold, size: 30)
        cView.addSubview(label)
        
        let label1 = UILabel()
        label1.frame = CGRect(x: 0, y: 50, width: 100, height: 50)
        label1.text = "TEXT"
        label1.textColor = UIColor.th.tint
        label1.font = UIFont.boldSystemFont(ofSize: 30)
        cView.addSubview(label1)
        
        //cView.th.showMask()
        cView.th.showMask(color: UIColor.purple.withAlphaComponent(0.35))
        
        btnShow.setTitle("show", for: .normal)
        btnShow.setTitleColor(.blue, for: .normal)
        btnShow.frame = CGRect(x: 0, y: 0, width: 100, height: 40)
        btnShow.center = CGPoint(x: view.center.x, y: cView.frame.maxY + 50)
        view.addSubview(btnShow)
        btnShow.addTarget(self, action: #selector(showPresent), for: .touchUpInside)
        let sTel = "18081003733".th.telSecury
        let name = "ReloadUI".th.noticeName
        print("🐌 fdas")
    }
    
    @objc func showPresent() {
        present(THPresentViewController(), animated: true, completion: nil)
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
            if index == 1 {
                cView.th.showMask(color: nil)
            } else {
                UIAlertController.th.showAlert(withTitle: "Index", message: "\(index)")
            }
        }
        
    }
    
}

//
//  ViewController2.swift
//  Thin_Example
//
//  Created by JuanFelix on 2019/12/31.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        th.addNavBarButton(texts: ["Logout"], at: .left, font: UIFont(name: "Bradley Hand", size: 16)!, color: .purple)
        th.addNavBarButton(texts: ["1", "2", "3"], at: .right, fixSpace: 20)
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
        UIAlertController.th.showAlert(withTitle: "Index", message: "\(index)")
    }   

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

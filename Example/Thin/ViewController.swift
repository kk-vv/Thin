//
//  ViewController.swift
//  Thin
//
//  Created by iFallen on 12/30/2019.
//  Copyright (c) 2019 iFallen. All rights reserved.
//

import UIKit
import Thin

class ViewController: UIViewController, UIGestureRecognizerDelegate{
    
    @IBOutlet weak var tblList: UITableView!
    
    let list1 = [("Title", UIFont.th.title(), UIColor.th.title),
    ("Tint", UIFont.th.title(), UIColor.th.tint),
    ("SubTint", UIFont.th.title(), UIColor.th.subTint),
    ("Background fix -1", UIFont.th.body(fix: -1), UIColor.th.bg),
    ("SubBackground fix -2", UIFont.th.body(fix: -2), UIColor.th.subBg)]
    
    let list2 = [("Separator", UIFont.th.body(), UIColor.th.separator),
                 ("Border", UIFont.th.body(), UIColor.th.border),
                 ("Empty", UIFont.th.body(), UIColor.th.empty),
                 ("Title", UIFont.th.title(), UIColor.th.title)]
    
    let list3 = [("Body", UIFont.th.body(), UIColor.th.body),
                 ("SubBody", UIFont.th.body(fix: -1), UIColor.th.subBody),
                 ("Mark1", UIFont.th.mark(), UIColor.th.mark1),
                 ("Mark2 fix -2", UIFont.th.mark(fix: -2), UIColor.th.mark2)]
    
    var list = [(String, UIFont, UIColor)]()
    
    override func loadView() {
        super.loadView()
        self.title = "Title"
        th.clearNavBarBackButtonTitle()
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("🐌 \(Bundle.th.projectName)")
        print("🐌 \(Bundle.th.bundleId)")
        print("🐌 \(Bundle.th.version)")
        print("🐌 \(Bundle.th.build)")
        
        th.addNavBarButton(texts: ["Next"], at: .right)
        
        list.append(contentsOf: list1)
        list.append(contentsOf: list2)
        list.append(contentsOf: list3)
        
        //TabBarAppearance.active(tabBar: (UIApplication.shared.keyWindow?.rootViewController as? UITabBarController)?.tabBar)
        view.backgroundColor = self.color
        
        tblList.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.th.reuseIdentifier)
        tblList.delegate = self
        tblList.dataSource = self
        
    }
    
    var color: UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.init { (trait) -> UIColor in
                if trait.userInterfaceStyle == .dark {
                    return .black
                }
                return .white
            }
        } else {
            // Fallback on earlier versions
            return .white
        }
    }

    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if #available(iOS 13.0, *) {
            let trait = UITraitCollection.current.userInterfaceStyle
            if trait == .dark {
                NavBarAppearance.active(NavBarBuilder.dark)
                TabBarAppearance.active(TabBarBuilder.dark, tabBar: nil)
            } else {
                NavBarAppearance.active(NavBarBuilder.default)
                TabBarAppearance.active(TabBarBuilder.default, tabBar: nil)
            }
        }
    }

}

extension ViewController: UITableViewDelegate {
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.th.reuseIdentifier, for: indexPath)
        cell.contentView.backgroundColor = UIColor.th.subBg
        cell.textLabel?.text = list[indexPath.row].0
        cell.textLabel?.font = list[indexPath.row].1
        cell.textLabel?.textColor = list[indexPath.row].2
        return cell
    }
}


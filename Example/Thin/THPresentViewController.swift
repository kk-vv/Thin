//
//  THPresentViewController.swift
//  Thin_Example
//
//  Created by JuanFelix on 2020/1/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import ThinX

class THPresentViewController: PresentBaseViewController {

    override var dismissTapOutsideView: UIView? { return contentView }
    override var maskAlpha: CGFloat { return 0 }
    let contentView = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(contentView)
        contentView.frame = CGRect(x: 0, y: 0, width: 200, height: 60)
        contentView.center = view.center
        contentView.backgroundColor = UIColor.th.tint
        contentView.th.corners(.forwardSlash)
    }

}

extension THPresentViewController {
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let svc = SlideOutAnimationController()
        svc.duration = 0.5
        svc.to = .right
        return svc
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let svc = SlideInAnimationController()
        svc.from = .top
        return svc
    }
}

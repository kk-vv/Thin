//
//  DimmingPresentationController.swift
//  Thin
//
//  Created by JuanFelix on 2020/1/13.
//  Copyright © 2020 JuanFelix. All rights reserved.
//

import UIKit

public class DimmingPresentationController: UIPresentationController {
    public static var alpha: CGFloat = 0.25
    public var maskView:UIView!
    
    fileprivate func setupMaskView() {
        maskView = UIView(frame: CGRect.zero)
        maskView.isUserInteractionEnabled = false
        maskView.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: DimmingPresentationController.alpha)
    }
    
    public override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        setupMaskView()
    }
    
    public override func presentationTransitionWillBegin() {
        self.maskView.frame = (self.containerView?.bounds)!
        self.containerView?.insertSubview(self.maskView, at: 0)
        self.maskView.alpha = 0
        if (self.presentedViewController.transitionCoordinator != nil) {
            self.presentedViewController.transitionCoordinator?.animate(alongsideTransition: { (context) in
                self.maskView.alpha = 1
            }, completion: nil)
        }
    }
    
    override public func dismissalTransitionWillBegin() {
        if (self.presentedViewController.transitionCoordinator != nil) {
            self.presentedViewController.transitionCoordinator?.animate(alongsideTransition: { (context) in
                self.maskView.alpha = 0
            }, completion: nil)
        }
    }
    
    override public var shouldRemovePresentersView: Bool { return false }

}

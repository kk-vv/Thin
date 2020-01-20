//
//  PresentBaseViewController.swift
//  Thin
//
//  Created by JuanFelix on 2020/1/10.
//  Copyright © 2020 JuanFelix. All rights reserved.
//

import UIKit
import ThinX

public class PresentBaseViewController: UIViewController {
    
    public var dismissTapOutsideView: UIView? { return nil }
    public var maskAlpha: CGFloat { return 0.25 }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        transitioningDelegate = self
        modalPresentationStyle = .custom
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .clear
    }
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let outside = dismissTapOutsideView, let touch = touches.first {
            let position = touch.location(in: outside)
            if !outside.bounds.contains(position) {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
}

extension PresentBaseViewController: UIViewControllerTransitioningDelegate {
    public func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        DimmingPresentationController.alpha = self.maskAlpha
        return DimmingPresentationController.init(presentedViewController: presented, presenting: presenting)
    }
}

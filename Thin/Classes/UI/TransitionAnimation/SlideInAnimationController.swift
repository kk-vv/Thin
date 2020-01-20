//
//  SlideInAnimationController.swift
//  Thin
//
//  Created by JuanFelix on 2020/1/13.
//  Copyright © 2020 JuanFelix. All rights reserved.
//

import Foundation

public enum SlideDirection {
    case left, right, top
}

public class SlideInAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    public var from: SlideDirection = .left
    public var duration: TimeInterval = 0.25
    
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return self.duration
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let toViewController = transitionContext.viewController(forKey: .to)
        let toView = transitionContext.view(forKey: .to)
        let containerView = transitionContext.containerView
        if let toViewController = toViewController,
            let toView = toView {
            toView.frame = transitionContext.finalFrame(for: toViewController)
            switch from {
                case .left:
                toView.center = CGPoint(x: -containerView.center.x, y: containerView.center.y)
                case .right:
                toView.center = CGPoint(x: containerView.center.x * 3, y: containerView.center.y)
                case .top:
                toView.center = CGPoint(x: containerView.center.x, y: -containerView.center.y)
            }
            containerView.addSubview(toView)
            let duration = self.transitionDuration(using: transitionContext)
            UIView.animate(withDuration: duration, animations: {
                toView.center = containerView.center
            }, completion: { finished in
                transitionContext.completeTransition(finished)
            })
        }
    }
}

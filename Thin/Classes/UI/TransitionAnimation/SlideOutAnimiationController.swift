//
//  SlideOutAnimiationController.swift
//  Thin
//
//  Created by JuanFelix on 2020/1/13.
//  Copyright © 2020 JuanFelix. All rights reserved.
//

import Foundation

public class SlideOutAnimationController: NSObject, UIViewControllerAnimatedTransitioning {

    public var to: SlideDirection = .right
    public var duration: TimeInterval = 0.25
    
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return self.duration
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromView = transitionContext.view(forKey: .from)
        let containverView = transitionContext.containerView
        let duration = self.transitionDuration(using: transitionContext)
        if let fromView = fromView {
            UIView.animate(withDuration: duration, animations: {
                switch self.to {
                    case .left:
                        fromView.center = CGPoint(x: -(containverView.bounds.size.width * 0.5), y: fromView.center.y)
                    case .right:
                    fromView.center = CGPoint(x: containverView.bounds.size.width * 1.5, y: fromView.center.y)
                    case .top:
                    fromView.center = CGPoint(x: fromView.center.x, y: -(containverView.bounds.size.height * 0.5))
                }
            }, completion: { finished in
                transitionContext.completeTransition(finished)
            })
        }

    }
}

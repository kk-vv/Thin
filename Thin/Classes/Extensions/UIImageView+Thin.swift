//
//  UIImageView+Thin.swift
//  ThinX
//
//  Created by JuanFelix on 2020/1/10.
//

import Foundation

extension Thin where Base: UIView {
    public func showMask(color: UIColor? = UIColor.black.withAlphaComponent(0.35)) {
        guard let color = color else {
            if let view = self.base.viewWithTag(3636) {
                view.removeFromSuperview()
            }
            return
        }
        if let view = self.base.viewWithTag(3636) {
            view.backgroundColor = color
        } else {
            let view = UIView()
            view.isUserInteractionEnabled = false
            view.tag = 3636
            view.backgroundColor = color
            self.base.addSubview(view)
            
            view.translatesAutoresizingMaskIntoConstraints = false
            
            let left = NSLayoutConstraint(item: view, attribute: .left, relatedBy: .equal, toItem: self.base, attribute: .left, multiplier: 1, constant: 0)
            let right = NSLayoutConstraint(item: view, attribute: .right, relatedBy: .equal, toItem: self.base, attribute: .right, multiplier: 1, constant: 0)
            let top = NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal, toItem: self.base, attribute: .top, multiplier: 1, constant: 0)
            let bottom = NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal, toItem: self.base, attribute: .bottom, multiplier: 1, constant: 0)
            self.base.addConstraints([top, left, right, bottom])
        }
    }

}

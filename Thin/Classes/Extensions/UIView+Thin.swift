//
//  UIView+Thin.swift
//  Thin
//
//  Created by JuanFelix on 2020/1/10.
//

import UIKit

extension UIRectCorner: ThinCompatible {}

extension Thin where Base == UIRectCorner {
    public static var top: UIRectCorner { return [.topLeft, .topRight] }
    
    public static var bottom: UIRectCorner { return [.bottomLeft, .bottomRight] }
    
    public static var left: UIRectCorner { return [.topLeft, .bottomLeft] }
    
    public static var right: UIRectCorner { return [.topRight, .bottomRight] }
    
    public static var forwardSlash: UIRectCorner { return [.topRight, .bottomLeft] }
    
    public static var backSlash: UIRectCorner { return [.topLeft, .bottomRight] }

}

extension Thin where Base: UIView {
    public func corners(_ corners: UIRectCorner = .allCorners,
                 radii: CGFloat = 8,
                 bounds: CGRect? = nil) {
        var bounds = bounds
        if bounds == nil {
            bounds = self.base.bounds
        }
        let rect = UIBezierPath(roundedRect: bounds!, byRoundingCorners: corners, cornerRadii: CGSize(width: radii, height: radii))

        let cornerLayer = CAShapeLayer()
        //cornerLayer.bounds = self.base.bounds
        cornerLayer.frame = bounds!//set frame not bounds

        cornerLayer.path = rect.cgPath

        self.base.layer.mask = cornerLayer
    }

}

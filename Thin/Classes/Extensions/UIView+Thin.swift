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

public enum THRectCorners {
    case topLeft
    case topRight
    case bottomLeft
    case bottomRight
    case top
    case bottom
    case left
    case right
    case forwardSlash
    case backSlash
    case allCorners
    
    func corners() -> UIRectCorner {
        switch self {
        case .topLeft:
            return .topLeft
        case .topRight:
            return .topRight
        case .bottomLeft:
            return .bottomLeft
        case .bottomRight:
            return .bottomRight
        case .top:
            return UIRectCorner.th.top
        case .bottom:
            return UIRectCorner.th.bottom
        case .left:
            return UIRectCorner.th.left
        case .right:
            return UIRectCorner.th.right
        case .forwardSlash:
            return UIRectCorner.th.forwardSlash
        case .backSlash:
            return UIRectCorner.th.backSlash
        case .allCorners:
            return .allCorners
        }
    }
}

extension Thin where Base: UIView {
    public func corners(_ corners: THRectCorners = .allCorners,
                 radii: CGFloat = 8,
                 bounds: CGRect? = nil) {
        var bounds = bounds
        if bounds == nil {
            bounds = self.base.bounds
        }
        let rect = UIBezierPath(roundedRect: bounds!, byRoundingCorners: corners.corners(), cornerRadii: CGSize(width: radii, height: radii))

        let cornerLayer = CAShapeLayer()
        //cornerLayer.bounds = self.base.bounds
        cornerLayer.frame = bounds!//set frame not bounds

        cornerLayer.path = rect.cgPath

        self.base.layer.mask = cornerLayer
    }

}

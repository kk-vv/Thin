//
//  THReuseableView.swift
//  Thin
//
//  Created by JuanFelix on 2019/12/30.
//

import Foundation

public protocol ReusableView: class {}
public protocol NibLoadableView: class {}

extension Thin where Base: ReusableView {
    public static var reuseIdentifier: String {
        return String(describing: Base.self)
    }
}

extension Thin where Base: NibLoadableView {
    public static var nibName: String {
        return String(describing: Base.self)
    }
}

extension UITableViewCell: ReusableView, NibLoadableView {}
//extension UICollectionViewCell: ReusableView, NibLoadableView {}
extension UITableViewHeaderFooterView: ReusableView, NibLoadableView {}
extension UICollectionReusableView: ReusableView, NibLoadableView {}

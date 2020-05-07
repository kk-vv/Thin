//
//  String+Thin.swift
//  Thin
//
//  Created by JuanFelix on 2019/12/30.
//

import Foundation

extension String: ThinCompatible {}

extension Thin where Base == String {
    
    public func index(at: Int) -> String.Index {
        return self.base.index(self.base.startIndex, offsetBy: at)
    }
    
    public func subs(from: Int) -> String {
        let fromIndex = index(at: from)
        return String(self.base[fromIndex..<self.base.endIndex])
    }
    
    public func subs(to: Int) -> String {
        let toIndex = index(at: to)
        return String(self.base[self.base.startIndex..<toIndex])
    }
    
    public func subs(with r:Range<Int>) -> String {
        let startIndex  = index(at: r.lowerBound)
        let endIndex    = index(at: r.upperBound)
        return String(self.base[startIndex..<endIndex])
    }

}


extension Thin where Base == String {
    
    /// MATCHES
    ///
    /// - Parameter string: -
    /// - Returns: -
    public func matchs(regular string:String) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@",string)
        return predicate.evaluate(with:self)
    }
    
    /// Rect
    ///
    /// - Parameters:
    ///   - font: -
    ///   - limiteSize: -
    /// - Returns: -
    public func rect(_ font:UIFont,
                     limiteSize:CGSize,
                     linespacing: CGFloat = 10) -> CGSize {
        let size = (base as NSString).boundingRect(with: limiteSize,
                                                   options: NSStringDrawingOptions(rawValue: NSStringDrawingOptions.usesLineFragmentOrigin.rawValue|NSStringDrawingOptions.truncatesLastVisibleLine.rawValue),
                                                   attributes: [NSAttributedString.Key.font: font, NSAttributedString.Key.paragraphStyle: NSAttributedString.th.lineSpacing(linespacing, font: font)],
                                                   context: nil).size
        return size
    }
        
    public var noticeName: NSNotification.Name {
        return NSNotification.Name.init(self.base)
    }
    
    public var telSecury: String {
        if self.base.count > 4 {
            let head = base.th.subs(with: 0..<3)
            let tail = base.th.subs(with: (base.count - 4)..<base.count)
            return "\(head)****\(tail)"
        }
        return self.base
    }
    
    /// Currency format attributedString
    ///
    /// - Parameters:
    ///   - size: text size
    ///   - intBodySize: int size
    ///   - color: color
    ///   - fontName: font name
    /// - Returns: NSMutableAttributedString
    public func attributedCurrencyStr(size:CGFloat,
                                intBodySize: CGFloat,
                                color: UIColor = .black,
                                fontName: String = "Arial") -> NSMutableAttributedString {
        let price = self.currencyString("¥", isGroup: true, noFractionifInt: false)
        let aRange = NSMakeRange(0, price.count)//¥ + 小数部分
        var pRange = NSMakeRange(1, price.count)//数值
        
        let location = (price as NSString).range(of: ".")
        if  location.length > 0 {
            pRange = NSMakeRange(1, location.location)//整数部分
        }
        let formatPrice = NSMutableAttributedString.init(string: price)
        formatPrice.th.setColor(color, at: aRange)
        formatPrice.th.setFont(UIFont(name: fontName, size: size) ?? UIFont.systemFont(ofSize: size), at: aRange)
        formatPrice.th.setFont(UIFont(name: fontName, size: intBodySize) ?? UIFont.systemFont(ofSize: intBodySize), at: pRange)
        return formatPrice
    }
    
    /// Price format attributedString
    ///
    /// - Parameter color: text color
    /// - Returns: NSMutableAttributedString
    public func attributedCurrencyStr(color: UIColor?) -> NSMutableAttributedString {
        return self.attributedCurrencyStr(size: 12, intBodySize: 15, color: color ?? UIColor.black)
    }
    
    /// Price format string
    /// - Parameters:
    ///   - unit: unit description
    ///   - isGroup: , split
    ///   - noFractionifInt: 整数是否保留小数点后面两个0
    /// - Returns: String
    public func currencyString(_ unit: String?, isGroup: Bool, noFractionifInt: Bool) -> String {
        var price = base
        if price.count <= 0 {
            price = "0"
        }
        let location = (price as NSString).range(of: ".")
        if  location.length <= 0 {
            price += ".00"
        } else {
            let tail = price.th.subs(from: location.location)
            if tail.count < 3 {//包含点
                price += "0"
            } else {
                price = price.th.subs(to: location.location) + tail.th.subs(to: 3)
            }
        }
        if noFractionifInt {
            let location = (price as NSString).range(of: ".")
            if  location.length > 0 {
                let tail = price.th.subs(from: location.location)
                if tail == ".0" || tail == ".00" {
                    price = price.th.subs(to: location.location)
                }
            }
        }
        
        if isGroup {
            price = price.replacingOccurrences(of: "(?<=\\d)(?=(\\d\\d\\d)+(?!\\d))", with: ",", options: .regularExpression, range: price.startIndex..<price.endIndex)
        }
        if let unit = unit, !unit.isEmpty {
            if !price.hasPrefix(unit) {
                return "\(unit)\(price)"
            }
        }
        return price
    }
    
    public func dateValue(format: String) -> Date? {
        let formatter = DateFormatter()
        formatter.timeZone = NSTimeZone(forSecondsFromGMT: +28800) as TimeZone
        formatter.dateFormat = format
        return formatter.date(from: base)
    }

}

extension Thin where Base: NSNumber {
    public func currencyString(_ unit:Bool) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = 2
        var str = formatter.string(from: base) ?? "¥0.00"
        str = str.replacingOccurrences(of: "^[ a-zA-Z]*", with: "", options: .regularExpression, range: str.startIndex..<str.endIndex)
        str = str.replacingOccurrences(of: "$", with: "¥")
        if unit {
            return str
        } else {
            return str.th.subs(from: 1)
        }
    }
}

extension Dictionary: ThinCompatible {}
extension Array: ThinCompatible {}

extension Thin where Base == Dictionary<String, Any> {
    public var sortedJsonString: String {
        let tempDic = base
        var keys = Array<String>()
        for key in tempDic.keys {
            keys.append(key)
        }
        keys.sort { $0 < $1 }
        var signString = "{"
        var arr: Array<String> = []
        for key in keys {
            let value = tempDic[key]
            if let value = value as? Dictionary<String,Any> {
                arr.append("\"\(key)\":\(value.th.sortedJsonString)")
            }else if let value = value as? Array<Any> {
                arr.append("\"\(key)\":\(value.th.sortedJsonString)")
            }else{
                arr.append("\"\(key)\":\"\(tempDic[key]!)\"")
            }
        }
        signString += arr.joined(separator: ",")
        signString += "}"
        return signString
    }
}

extension Thin where Base == Array<Any> {
    public var sortedJsonString: String {
        let array = base
        var arr: Array<String> = []
        var signString = "["
        for value in array {
            if let value = value as? Dictionary<String,Any> {
                arr.append(value.th.sortedJsonString)
            }else if let value = value as? Array<Any> {
                arr.append(value.th.sortedJsonString)
            }else{
                arr.append("\"\(value)\"")
            }
        }
        arr.sort { $0 < $1 }
        signString += arr.joined(separator: ",")
        signString += "]"
        return signString
    }
}


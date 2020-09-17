//
//  BaseNumber.swift
//  YHKit-Swift
//
//  Created by Champion Fu on 2020/9/15.
//  Copyright © 2020 Champion Fu. All rights reserved.
//

import UIKit

extension String {
    
    var float: Float { Float(self) ?? 0.0 }
    var cgFloat: CGFloat { CGFloat(double) }
    var double: Double { Double(self) ?? 0.0 }
    var cint: Int { Int(ceil(double)) }
    
    ///做了四舍五入
    var int: Int {  Double(cint) - double < 0.5 ? cint : fint }
    
    var fint: Int { Int(floor(double)) }
    
    var bool: Bool { !(self.float == 0.0) }
}



extension Int {
    var float: Float { Float(self) }
    var cgFloat: CGFloat { CGFloat(self) }
    var double: Double { Double(self) }
    var bool: Bool { !(self == 0) }
    var string: String { "\(self)" }
}

extension Double {
    var float: Float { Float(self) }
    var cgFloat: CGFloat { CGFloat(self) }
    var cint: Int { Int(ceil(self)) }
    
    ///做了四舍五入
    var int: Int { Double(cint) - self < 0.5 ? cint : fint }
    
    var fint: Int { Int(floor(self)) }
    var bool: Bool { !(self == 0.0) }
    var string: String { "\(self)" }
    ///保留有效小数位，去除小数后面多余的0
    var realString: String { String(format: "%@", NSNumber(value: self)) }
    /// x：需要保留的整数位数，至少为1，y需要保留的小数位数，至少为0
    func stringFormat(_ x: Int = 1, _ y: Int) -> String {
        let x = max(x, 1)
        let y = max(y, 0)
        let xFormat = x == 1 ? "" : "0\(x)"
        let yFormat = "\(y)"
        let format = "%\(xFormat).\(yFormat)lf"
        return String(format: format, self)
    }
}

extension CGFloat {
    var double: Double { Double(self) }
    var float: Float { Float(self) }
    var cint: Int { Int(ceil(self)) }
    var fint: Int { Int(floor(self)) }
    ///四舍五入
    var int: Int { CGFloat(cint) - self < 0.5 ? cint : fint }
    var bool: Bool { !(self == 0.0) }
    var string: String { "\(self)" }
    ///保留有效小数位，去除小数后面多余的0
    var realString: String { String(format: "%@", NSNumber(value: double)) }
    /// x：需要保留的整数位数，至少为1，y需要保留的小数位数，至少为0
    func stringFormat(_ x: Int = 1, _ y: Int) -> String {
        let x = x < 1 ? 1 : x
        let y = y < 0 ? 0 : y
        let xFormat = x == 1 ? "" : "0\(x)"
        let yFormat = "\(y)"
        let format = "%\(xFormat).\(yFormat)lf"
        return String(format: format, self)
    }
}

extension Float {
    var double: Double { Double(self) }
    var cgFloat: CGFloat { CGFloat(self) }
    var cint: Int { Int(ceil(self)) }
    var fint: Int { Int(floor(self)) }
    ///四舍五入
    var int: Int { Float(cint) - self < 0.5 ? cint : fint }
    var bool: Bool { !(self == 0.0) }
    var string: String { "\(self)" }
    ///保留有效小数位，去除小数后面多余的0
    var realString: String { String(format: "%@", NSNumber(value: self)) }
    /// x：需要保留的整数位数，至少为1，y需要保留的小数位数，至少为0
    func stringFormat(_ x: Int = 1, _ y: Int) -> String {
        let x = max(x, 1)
        let y = max(y, 0)
        let xFormat = x == 1 ? "" : "0\(x)"
        let yFormat = "\(y)"
        let format = "%\(xFormat).\(yFormat)lf"
        return String(format: format, self)
    }
    
}

extension Bool {
    var double: Double { Double(self ? 1 : 0) }
    var cgFloat: CGFloat { CGFloat(self ? 1 : 0) }
    var float: Float { Float(self ? 1 : 0) }
    
    var int: Int { self ? 1 : 0 }
    var string: String { "\(self)" }
}

extension CGRect {
    var bounds: CGRect {
        return CGRect(origin: .zero, size: size)
    }
    var center: CGPoint {
        return CGPoint(x: width / 2, y: height / 2)
    }
}

extension CGSize {
    init(side: CGFloat) {
        self.init(width: side, height: side)
    }
}

extension UIEdgeInsets {
    init(padding: CGFloat) {
        self.init(top: padding, left: padding, bottom: padding, right: padding)
    }
    init(horizontal: CGFloat, vertical: CGFloat) {
        self.init(top: vertical, left: horizontal, bottom: vertical, right: horizontal)
    }
    
    var anti: UIEdgeInsets {
        return UIEdgeInsets(top: -top, left: -left, bottom: -bottom, right: -right)
    }
}

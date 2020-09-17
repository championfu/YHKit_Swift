//
//  UIColor.swift
//  YHKit-Swift
//
//  Created by Champion Fu on 2020/9/15.
//  Copyright © 2020 Champion Fu. All rights reserved.
//

import UIKit

extension UIColor {
    static var random: UIColor {
        let r = arc4random_uniform(256)
        let g = arc4random_uniform(256)
        let b = arc4random_uniform(256)
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: 1)
    }
    
    var image: UIImage {
        UIImage.imageWidth(color: self)!
    }
    
    convenience init(rgb r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat = 1) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
    }
    
    convenience init(gray v: CGFloat) {
        self.init(red: v / 255.0, green: v / 255.0, blue: v / 255.0, alpha: 1)
    }
    
    convenience init(hex string: String, alpha: CGFloat = 1.0) {
        
        var hex = string.hasPrefix("#") ? String(string.dropFirst()) : string
        guard hex.count == 3 || hex.count == 6  else {
            self.init(white: 1.0, alpha: 0.0)
            return
        }
        
        if hex.count == 3 {
            for (indec, char) in hex.enumerated() {
                hex.insert(char, at: hex.index(hex.startIndex, offsetBy: indec * 2))
            }
        }
        
        self.init(
            red: CGFloat((Int(hex, radix: 16)! >> 16) & 0xFF) / 255.0,
            green: CGFloat((Int(hex, radix: 16)! >> 8) & 0xFF) / 255.0,
            blue: CGFloat((Int(hex, radix: 16)!) & 0xFF) / 255.0,
            alpha: alpha
        )
    }
    
    
    static func dynamicGray(_ v: CGFloat) -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor { (t) -> UIColor in
                return t.userInterfaceStyle == .dark ? GRAY(255 - v) : GRAY(v)
            }
        }else {
            return GRAY(v)
        }
    }
    
    static func dynamicColor(_ lColor: UIColor, dColor: UIColor) -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor { (t) -> UIColor in
                return t.userInterfaceStyle == .dark ? dColor : lColor
            }
        }else {
            return lColor
        }
    }
    
}

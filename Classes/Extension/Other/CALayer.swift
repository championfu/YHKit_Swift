//
//  CALayer.swift
//  YHKit-Swift
//
//  Created by Champion Fu on 2020/9/14.
//  Copyright © 2020 Champion Fu. All rights reserved.
//

import UIKit

extension CALayer {
    func addShadow(color: UIColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1), offset: CGSize = .zero, radius: CGFloat = 3.0, opacity: Float = 1, pathSize: CGSize = .zero) {
        self.shadowColor = color.cgColor
        self.shadowOffset = offset
        self.shadowRadius = radius
        self.shadowOpacity = opacity
        let sz = (pathSize != .zero) ? pathSize : frame.size
        let path = UIBezierPath(roundedRect: CGRect(origin: CGPoint.zero, size: sz), cornerRadius: self.cornerRadius)
        self.shadowPath = path.cgPath
    }
    
    func addCorner(radius: CGFloat, color: UIColor = .clear, width: CGFloat = 0) {
        if !self.masksToBounds {
            self.masksToBounds = true
        }
        cornerRadius = radius
        borderColor = color.cgColor
        borderWidth = width
    }
}

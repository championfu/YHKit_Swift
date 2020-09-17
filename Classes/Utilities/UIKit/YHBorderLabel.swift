//
//  YHBorderLabel.swift
//  YHKit-Swift
//
//  Created by Champion Fu on 2020/9/15.
//  Copyright © 2020 Champion Fu. All rights reserved.
//

import UIKit
class YHBorderLabel: UILabel {
    var textInset: UIEdgeInsets = .zero {
        didSet {
            invalidateIntrinsicContentSize()
            setNeedsDisplay()
        }
    }
    
    override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        let rect = super.textRect(forBounds: bounds, limitedToNumberOfLines: numberOfLines)
        return rect.inset(by: textInset.anti)
    }
    
    override func drawText(in rect: CGRect) {
        //文本的绘区域不变
        super.drawText(in: rect.inset(by: textInset))
    }
    
    
}

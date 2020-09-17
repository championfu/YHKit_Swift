//
//  YHButton.swift
//  ShangLian
//
//  Created by Champion Fu on 2019/7/25.
//  Copyright © 2019 Champion Fu. All rights reserved.
//

import UIKit



class YHButton: UIButton {
    
    enum YHButtonImageDirection {
        case left /// 图片在左
        case right /// 图片在右
        case top /// 图片在上
        case bottom /// 图片在下
    }
    
    var gap : CGFloat = 5 {
        didSet {
            layoutIfNeeded()
        }
    }
    
    var direction: YHButton.YHButtonImageDirection = .left {
        didSet {
            layoutIfNeeded()
        }
    }
    
    var titleSize: CGSize? {
        didSet {
            layoutIfNeeded()
        }
    }
    
    var imageSize: CGSize? {
        didSet {
            layoutIfNeeded()
        }
    }
    
    var offset: CGPoint = .zero {
        didSet {
            self.invalidateIntrinsicContentSize()
            self.setNeedsLayout()
        }
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        var imageWidth: CGFloat
        if let imgW = imageSize?.width {
            imageWidth = imgW
        }else {
            imageWidth = imageView?.intrinsicContentSize.width ?? 0
        }
        
        var imageHeight: CGFloat
        if let imgH = imageSize?.height {
            imageHeight = imgH
        }else {
            imageHeight = imageView?.frame.size.width ?? 0
        }
        let text_size = imageView?.intrinsicContentSize ?? .zero
        var titleWidth: CGFloat
        if let titleW = titleSize?.width {
            titleWidth = titleW
        }else {
            titleWidth = text_size.width
        }
        
        var titleHeight: CGFloat
        if let titleH = titleSize?.height {
            titleHeight = titleH
        }else {
            titleHeight = text_size.height
        }
        
        var titleX: CGFloat, titleY: CGFloat
        var imageX: CGFloat, imageY: CGFloat
        
        let hMargin = (frame.size.width - gap - imageWidth - titleWidth) / 2
        let vMargin = (frame.size.height - gap - imageHeight - titleHeight) / 2
        
        switch direction {
        case .left:
            imageX = hMargin + offset.x
            imageY = (frame.height - imageHeight) / 2 + offset.y
            titleX = imageX + imageWidth + gap
            titleY = (frame.height - titleHeight) / 2 + offset.y
        case .right:
            titleX = hMargin + offset.x
            titleY = (frame.height - titleHeight) / 2 + offset.y
            imageX = titleX + titleWidth + gap
            imageY = (frame.height - imageHeight) / 2 + offset.y
        case .top:
            imageX = (frame.width - imageWidth) / 2 + offset.x
            imageY = vMargin + offset.y
            titleX = (frame.width - titleWidth) / 2 + offset.x
            titleY = imageY + imageHeight + gap
        default:
            titleX = (frame.width - titleWidth) / 2 + offset.x
            titleY = vMargin + offset.y
            imageX = (frame.width - imageWidth) / 2 + offset.x
            imageY = titleY + titleHeight + gap
        }
        titleLabel?.frame = CGRect(x: titleX, y: titleY, width: titleWidth, height: titleHeight)
        imageView?.frame = CGRect(x: imageX, y: imageY, width: imageWidth, height: imageHeight)
    }

}

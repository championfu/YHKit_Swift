//
//  UIButton.swift
//  YHKit-Swift
//
//  Created by Champion Fu on 2020/9/15.
//  Copyright © 2020 Champion Fu. All rights reserved.
//

import UIKit

extension UIButton {
    
    /// 纯文字 多状态 非富文本
    convenience init(titleButton title: String, fSize: CGFloat, tColor: UIColor, bgImage: UIImage? = nil) {
        self.init(titleButton: [title], fSizes: [fSize], tColors: [tColor], states: [.normal], bgImages: bgImage == nil ? nil : [bgImage!])
    }
    
    /// 纯文字 单状态 富文本
    convenience init(titleButton attributeString: NSAttributedString, bgImage: UIImage? = nil) {
        self.init(titleButton: [attributeString], states: [.normal], bgImages: bgImage == nil ? nil : [bgImage!])
    }
    
    /// 纯文字 多状态 非富文本
    convenience init(titleButton titles: [String], fSizes: [CGFloat], tColors: [UIColor], states: [UIControl.State], bgImages: [UIImage]? = nil) {
        self.init()
        setStates(titleButton: titles, fSizes: fSizes, tColors: tColors, states: states, bgImages: bgImages)
    }
    
    /// 纯文字 多状态 富文本
    convenience init(titleButton attributeStrings: [NSAttributedString], states: [UIControl.State], bgImages: [UIImage]? = nil) {
        self.init()
        setStates(titleButton: attributeStrings, states: states, bgImages: bgImages)
    }
    
    /// 纯文字 单状态 非富文本
    func setState(titleButton title: String, fSize: CGFloat, tColor: UIColor, bgImage: UIImage? = nil) {
        setStates(titleButton: [title], fSizes: [fSize], tColors: [tColor], states: [.normal], bgImages: bgImage == nil ? nil : [bgImage!])
    }
    
    /// 纯文字 多状态 非富文本
    func setStates(titleButton titles: [String], fSizes: [CGFloat], tColors: [UIColor], states: [UIControl.State], bgImages: [UIImage]? = nil) {
        
        var attrs: [NSAttributedString] = []
        for (index, _) in states.enumerated() {
            let title = titles[index]
            let fSize = fSizes[index]
            let tColor = tColors[index]
            let attr = NSAttributedString(string: title, fontSize: fSize, tColor: tColor)
            attrs.append(attr)
        }
        setStates(titleButton: attrs, states: states, bgImages: bgImages)
    }
    
    /// 纯文字 单状态 富文本
    func setState(titleButton attributeString: NSAttributedString, bgImage: UIImage? = nil) {
        setStates(titleButton: [attributeString], states: [.normal], bgImages: bgImage == nil ? nil : [bgImage!])
    }
    
    /// 纯文字 多状态 富文本
    func setStates(titleButton attributeStrings: [NSAttributedString], states: [UIControl.State], bgImages: [UIImage]? = nil) {
        addTouchEffect()
        for (index, st) in states.enumerated() {
            self.setAttributedTitle(attributeStrings[index], for: st)
            if let bgImages = bgImages {
                let bgImage = bgImages.count == 1 ? bgImages.first! : bgImages[index]
                self.setBackgroundImage(bgImage, for: st)
            }
        }
    }
    
    func addTouchEffect() {
        
        self.reversesTitleShadowWhenHighlighted = true
        self.showsTouchWhenHighlighted = true
        self.adjustsImageWhenDisabled = true
        self.adjustsImageWhenHighlighted = true
        
    }
    
    
    /// 纯图片 单状态
    convenience init(imageButton image:UIImage, bgImage: UIImage? = nil) {
        self.init(imageButton: [image], states: [.normal], bgImages: bgImage == nil ? nil : [bgImage!])
        
    }
    
    /// 纯图片 多状态
    convenience init(imageButton images:[UIImage], states: [UIControl.State], bgImages: [UIImage]? = nil) {
        self.init()
        setStates(imageButton: images, states: states, bgImages: bgImages)
    }
    
    /// 纯图片 单状态
    func setState(imageButton image:UIImage, bgImage: UIImage? = nil) {
        setStates(imageButton: [image], states: [.normal], bgImages: bgImage == nil ? nil : [bgImage!])
    }
    
    /// 纯图片 多状态
    func setStates(imageButton images:[UIImage], states: [UIControl.State], bgImages: [UIImage]? = nil) {
        assert(images.count == states.count, "数组元素个数不一致")
        for (index, st) in states.enumerated() {
            let img = images.count == 1 ? images.first! : images[index]
            setImage(img, for: st)
            if let bgImages = bgImages {
                let bgImage = bgImages.count == 1 ? bgImages.first! : bgImages[index]
                self.setBackgroundImage(bgImage, for: st)
            }
        }
    }
    

    /// 图文混合 多状态 富文本
    func setStates(mixButton attributeStrings: [NSAttributedString], images: [UIImage], states: [UIControl.State], bgImages: [UIImage]? = nil) {
        for (index, st) in states.enumerated() {
            let attr = attributeStrings[index]
            let img = images[index]
            setImage(img, for: st)
            setAttributedTitle(attr, for: st)
            if let bgImages = bgImages {
                let bgImage = bgImages.count == 1 ? bgImages.first! : bgImages[index]
                self.setBackgroundImage(bgImage, for: st)
            }
        }
    }
    
    /// 图文混合 单状态 富文本
    func setState(mixButton attributeString: NSAttributedString, image: UIImage, bgImage: UIImage? = nil) {
        setStates(mixButton: [attributeString], images: [image], states: [.normal], bgImages: bgImage == nil ? nil : [bgImage!])
    }
    
    /// 图文混合 多状态 非富文本
    func setStates(mixButton titles: [String], fSizes: [CGFloat], tColors: [UIColor], images: [UIImage], states: [UIControl.State], bgImages: [UIImage]? = nil) {
        
        var attrs: [NSAttributedString] = []
        for (index, _) in states.enumerated() {
            let title = titles[index]
            let fSize = fSizes[index]
            let tColor = tColors[index]
            let attr = NSAttributedString(string: title, fontSize: fSize, tColor: tColor)
            attrs.append(attr)
        }
        setStates(mixButton: attrs, images: images, states: states, bgImages: bgImages)
    }
    
    /// 图文混合 单状态 非富文本
    func setState(mixButton title: String, fSize: CGFloat, tColor: UIColor, image: UIImage, bgImage: UIImage? = nil) {
        setStates(mixButton: [title], fSizes: [fSize], tColors: [tColor], images: [image],states: [.normal], bgImages: bgImage == nil ? nil : [bgImage!])
    }
    
    /// 图文混合 多状态 富文本
    convenience init(mixButton attributeStrings: [NSAttributedString], images: [UIImage], states: [UIControl.State], bgImages: [UIImage]? = nil) {
        self.init()
        setStates(mixButton: attributeStrings, images: images, states: states, bgImages: bgImages)
    }
    
    /// 图文混合 单状态 富文本
    convenience init(mixButton attributeString: NSAttributedString, image: UIImage, bgImage: UIImage? = nil) {
        self.init(mixButton: [attributeString], images: [image], states: [.normal], bgImages: bgImage == nil ? nil : [bgImage!])
    }
    
    /// 图文混合 多状态 非富文本
    convenience init(mixButton titles: [String], fSizes: [CGFloat], tColors: [UIColor], images: [UIImage], states: [UIControl.State], bgImages: [UIImage]? = nil) {
        self.init()
        setStates(mixButton: titles, fSizes: fSizes, tColors: tColors, images: images, states: states, bgImages: bgImages)
    }
    
    /// 图文混合 单状态 非富文本
    convenience init(mixButton title: String, fSize: CGFloat, tColor: UIColor, image: UIImage, bgImage: UIImage? = nil) {
        self.init(mixButton: [title], fSizes: [fSize], tColors: [tColor], images: [image], states: [.normal], bgImages: bgImage == nil ? nil : [bgImage!])
    }
    
}

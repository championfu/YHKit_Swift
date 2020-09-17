//
//  UITextView.swift
//  YHKit-Swift
//
//  Created by Champion Fu on 2020/9/15.
//  Copyright © 2020 Champion Fu. All rights reserved.
//

import UIKit

private var attributesKey: Void?

extension UITextView {
    typealias AString = NSAttributedString
    typealias AKey = NSAttributedString.Key
    /// 一个存储富文本的数组，将富文本分解成多个attributes不同的富文本，
    /// 这样可以使用数组下标来修改富文本而不是通过范围（Range）来修改
    
    
    @objc var fontHeight: CGFloat {
        self.font!.lineHeight
    }
    
    @objc var attributedTexts: [AString]? {
        set {
            objc_setAssociatedObject(self, &attributesKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            objc_getAssociatedObject(self, &attributesKey) as? [AString]
        }
    }
    
    func setAttributes(_ attributes: [AKey: Any], at index: Int ) {
        if var attributedStrings = attributedTexts, index >= 0 && attributedStrings.count > index {
            let attributedString = AString(string: attributedStrings[index].string, attributes: attributes)
            attributedStrings[index] = attributedString
            self.attributedTexts = attributedStrings
            attributedText = AString(attributedStrings: attributedStrings)
        }
    }
    
    func setString(_ string: String, at index: Int) {
        if var attributedStrings = attributedTexts, index >= 0 && attributedStrings.count > index {
            let attributes = attributedStrings[index].attributes(at: 0, effectiveRange: nil)
            let attributedString = AString(string: string, attributes: attributes)
            attributedStrings[index] = attributedString
            self.attributedTexts = attributedStrings
            attributedText = AString(attributedStrings: attributedStrings)
        }
    }
    
    func setAString(_ aString: AString, at index: Int) {
        if var attributedStrings = attributedTexts, index >= 0 && attributedStrings.count > index {
            attributedStrings[index] = aString
            self.attributedTexts = attributedStrings
            attributedText = AString(attributedStrings: attributedStrings)
        }
    }
    
    func insertAString(_ aString: AString, at index: Int) {
        if var attributedStrings = attributedTexts, index >= 0 && attributedStrings.count > index {
            attributedStrings.insert(aString, at: index)
            self.attributedTexts = attributedStrings
            attributedText = AString(attributedStrings: attributedStrings)
        }
    }
    
    func deleteAString(_ aString: AString, at index: Int) {
        if var attributedStrings = attributedTexts, index >= 0 && attributedStrings.count > index {
            attributedStrings.remove(at: index)
            self.attributedTexts = attributedStrings
            attributedText = AString(attributedStrings: attributedStrings)
        }
    }
    
    /// font必须先设置，后设置font，计算有误
    func fitWidth() -> CGFloat {
        text?.width(font!) ?? 0
    }
    
    /// font必须先设置，后设置font，计算有误
    func fitHeight(_ width: CGFloat) -> CGFloat {
        text?.height(font!, width) ?? 0
    }
}

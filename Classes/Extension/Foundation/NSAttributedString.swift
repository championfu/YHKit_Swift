//
//  NSAttributedString.swift
//  YHKit-Swift
//
//  Created by Champion Fu on 2020/9/14.
//  Copyright © 2020 Champion Fu. All rights reserved.
//

import UIKit

extension NSAttributedString {
    
    convenience init(string: String, font: UIFont, tColor: UIColor) {
        self.init(string: string, attributes: [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: tColor])
    }
    
    /// 字体大小负值时取粗体字
    convenience init(string: String, fontSize: CGFloat, tColor: UIColor) {
        let font: UIFont
        if fontSize >= 0 {
            font = UIFont.systemFont(ofSize: fontSize)
        }else {
            font = UIFont.boldSystemFont(ofSize: -fontSize)
        }
        self.init(string: string, font: font, tColor: tColor)
    }
    
    convenience init(attributedStrings: [NSAttributedString]) {
        self.init(attributedString: attributedStrings.reduce(NSAttributedString(), +))
    }
    
    ///设置文字图标
    static func attatchment(image: UIImage?, font: UIFont, color: UIColor? = nil, renderingMode: UIImage.RenderingMode = .automatic) -> NSMutableAttributedString {
        guard image != nil && image?.size.height != 0 else {
            return NSMutableAttributedString()
        }
        let attach = NSTextAttachment()
        attach.image = image?.withRenderingMode(renderingMode)
        
        let whRatio = image!.size.width / image!.size.height
        attach.bounds = CGRect(x: 0, y: font.descender, width: font.lineHeight*whRatio, height: font.lineHeight)
        let attr = NSMutableAttributedString(attachment: attach)
        if let color = color {
            attr.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: NSRange(location: 0, length: attr.length))
        }
        return attr
    }
    
    ///加号重载
    static func +(lhs: NSAttributedString, rhs: NSAttributedString) -> NSAttributedString {
        let attr = NSMutableAttributedString(attributedString: lhs)
        attr.append(rhs)
        return attr
    }
}

extension NSMutableAttributedString {
    
    typealias AKey = NSAttributedString.Key
    func setAttributes(with name: AKey, value: Any?, range: NSRange) {
        if let value = value {
            addAttribute(name, value: value, range: range)
        }else {
            removeAttribute(name, range: range)
        }
    }
    
    private func nonullRange(_ range: NSRange?) -> NSRange {
        if range == nil { return NSRange(location: 0, length: length) }
        return range!
    }
    /**
     *设置字体
     */
    
    func addFont(_ font: UIFont, range: NSRange? = nil) -> NSMutableAttributedString {
        setAttributes(with: AKey.font, value: font, range: nonullRange(range))
        return self
    }
    
    /**
     *设置字体颜色
     */
    func addColor(_ color: UIColor, range: NSRange? = nil) -> NSMutableAttributedString {
        setAttributes(with: AKey.foregroundColor, value: color, range: nonullRange(range))
        return self
    }
    
    /**
     *设置背景色
     */
    func addBgColor(_ color: UIColor, range: NSRange? = nil) -> NSMutableAttributedString {
        setAttributes(with: AKey.backgroundColor, value: color, range: nonullRange(range))
        return self
    }
    
    /**
     *添加连字效果，0：无效果 1：默认连字效果（一般中文用不到，在英文中可能出现相邻字母连笔的情况，此时会用到）
     */
    func addLigature(_ value: CGFloat = 0, range: NSRange? = nil) -> NSMutableAttributedString {
        setAttributes(with: AKey.ligature, value: value, range: nonullRange(range))
        return self
    }
    
    /**
     *字符间距，正数间距加大，负数间距缩小
     */
    func addKern(_ value: CGFloat, range: NSRange? = nil) -> NSMutableAttributedString {
        setAttributes(with: AKey.kern, value: value, range: nonullRange(range))
        return self
    }
    
    /**
     *添加删除线
     */
    func addDeleteLine(_ style: NSUnderlineStyle, _ color: UIColor, range: NSRange? = nil) -> NSMutableAttributedString {
        setAttributes(with: AKey.strikethroughStyle, value: style, range: nonullRange(range))
        setAttributes(with: AKey.strikethroughColor, value: color, range: nonullRange(range))
        return self
    }
    /**
     *添加下划线
     */
    func addUnderLine(_ style: NSUnderlineStyle, _ color: UIColor, range: NSRange? = nil) -> NSMutableAttributedString {
        setAttributes(with: AKey.underlineStyle, value: style, range: nonullRange(range))
        setAttributes(with: AKey.underlineColor, value: color, range: nonullRange(range))
        return self
    }
    
    /**
     *添加笔画描边，正数中空 负数填充
     */
    func addStroke(_ value: CGFloat, _ color: UIColor, range: NSRange? = nil) -> NSMutableAttributedString {
        setAttributes(with: AKey.strokeColor, value: color, range: nonullRange(range))
        setAttributes(with: AKey.strokeWidth, value: value, range: nonullRange(range))
        return self
    }
    
    /**
     *添加阴影
     */
    func addShadow(_ color: UIColor, radius: CGFloat, offset: CGSize = .zero, range: NSRange? = nil) -> NSMutableAttributedString {
        let s = NSShadow()
        s.shadowColor = color
        s.shadowBlurRadius = radius
        s.shadowOffset = offset
        setAttributes(with: AKey.shadow, value: s, range: nonullRange(range))
        return self
    }
    
    //添加文字特效，目前只支持`凸版印刷`这一种效果(NSTextEffectLetterpressStyle)
    func addTextEffect(_ effect: String, range: NSRange? = nil) -> NSMutableAttributedString {
        setAttributes(with: AKey.textEffect, value: effect, range: nonullRange(range))
        return self
    }
    
    /**
     *设置文本基准线的偏移值，正值向上便宜，负值向下偏移
     */
    func addBaselineOffset(_ offset: CGFloat, range: NSRange? = nil) -> NSMutableAttributedString {
        setAttributes(with: AKey.baselineOffset, value: offset, range: nonullRange(range))
        return self
    }
    
    /**
     *设置文字斜度，正值向右倾斜，负值向左倾斜, 0值不倾斜
     */
    func addObliqueness(_ value: CGFloat, range: NSRange? = nil) -> NSMutableAttributedString {
        setAttributes(with: AKey.obliqueness, value: value, range: nonullRange(range))
        return self
    }
    
    /**
     *设置文字拉伸，正值（排版方向）拉伸，负值（排版方向）压缩，0值无变化
     */
    func addExpansion(_ value: CGFloat, range: NSRange? = nil) -> NSMutableAttributedString {
        setAttributes(with: AKey.expansion, value: value, range: nonullRange(range))
        return self
    }
    /**
     *书写方向
     */
    func addWritingDirection(_ direction: [NSWritingDirection], range: NSRange? = nil) -> NSMutableAttributedString {
        setAttributes(with: AKey.writingDirection, value: direction, range: nonullRange(range))
        return self
    }
    
    /**
     *横竖排版，默认false，即横向排版
     */
    func addVerticalGlyphForm(_ vertical: Bool, range: NSRange? = nil) -> NSMutableAttributedString {
        setAttributes(with: AKey.verticalGlyphForm, value: vertical, range: nonullRange(range))
        return self
    }
    
    /**
     *添加链接
     */
    func addUrlLink(_ url: String, range: NSRange? = nil) -> NSMutableAttributedString {
        setAttributes(with: AKey.link, value: url, range: nonullRange(range))
        return self
    }
    
    
    /**
     *设置段落的各种属性 lineSpace:行间距 paraSpace:段落之间间距 firstLineIndent:第一行缩进 headIndent: 整体缩进
     *alignment:对其格式
     */
//    func addParagraphStyle(lineSpace: CGFloat, paraSpace: CGFloat, firstLineIndent: CGFloat, headIndent: CGFloat, alignment: NSTextAlignment, range: NSRange? = nil) -> NSMutableAttributedString {
//        let r = nonullRange(range)
//        self.setLineSpacing(lineSpace, range: r)
//        self.setParagraphSpacing(paraSpace, range: r)
//        self.setFirstLineHeadIndent(firstLineIndent, range: r)
//        self.setHeadIndent(headIndent, range: r)
//        self.setAlignment(alignment, range: r)
//        return self
//    }
    
    /**
     *设置段落
     */
//    func addParagraph(style: NSParagraphStyle, range: NSRange? = nil) -> NSMutableAttributedString {
//        let r = nonullRange(range)
//        self.setParagraphStyle(style, range: r)
//        return self
//    }
}


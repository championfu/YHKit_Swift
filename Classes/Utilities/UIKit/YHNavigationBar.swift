//
//  YHNavigationBar.swift
//  YHKit-Swift
//
//  Created by Champion Fu on 2020/9/15.
//  Copyright © 2020 Champion Fu. All rights reserved.
//

import UIKit

class YHNavigationBar: UIView {

    var titleView : UIView? {
        willSet {
            titleView?.removeFromSuperview()
        }
        didSet {
            if let v = titleView {
                self.addSubview(v)
                self.titleViewWidth = min(v.frame.width, self.titleMaxWidth)
                v.snp_makeConstraints { (make) in
                    make.centerX.equalTo(self)
                    make.centerY.equalTo(self.leftBox)
                    make.size.equalTo(CGSize(width: self.titleViewWidth, height: v.frame.height))
                }
            }
        }
    }
    
    var title : String? {
        didSet {
            titleLabel.text = title
            titleLabel.sizeToFit()
            titleView = titleLabel
        }
    }
    var leftItems : [UIButton]? {
        
        willSet {
            leftBoxWidth = 0
            if let oldItems = leftItems {
                self.leftBox.removeSubviews(oldItems)
            }
        }
        
        didSet {
            if let newItems = leftItems {
                newItems.forEach { (item) in
                    self.leftBox.addSubview(item)
                    item.snp_makeConstraints({ (make) in
                        make.centerY.equalTo(self.leftBox)
                        make.left.equalTo(self.leftBoxWidth)
                        make.size.equalTo(CGSize(width: item.frame.width, height: min(44, item.frame.height)))
                    })
                    self.leftBoxWidth += item.frame.width
                }
                
                leftBox.snp_updateConstraints { (make) in
                    make.width.equalTo(self.leftBoxWidth)
                }
                updateTitleWidth()
            }
        }
    }
    var rightItems : [UIButton]? {
        willSet {
            rightBoxWidth = 0
            if let oldItems = rightItems {
                self.rightBox.removeSubviews(oldItems)
            }
        }
        
        didSet {
            if let newItems = rightItems {
                newItems.forEach { (item) in
                    self.rightBox.addSubview(item)
                    item.snp_makeConstraints({ (make) in
                        make.centerY.equalTo(self.rightBox)
                        make.left.equalTo(self.rightBoxWidth)
                        make.size.equalTo(CGSize(width: item.frame.width, height: min(44, item.frame.height)))
                    })
                    self.rightBoxWidth += item.frame.width
                }
                rightBox.snp_updateConstraints { (make) in
                    make.width.equalTo(self.rightBoxWidth)
                }
                updateTitleWidth()
            }
        }
    }
    var leftItem : UIButton? {
        didSet {
            if let item = leftItem {
                leftItems = [item]
            }else {
                leftItems = nil
            }
        }
    }
    var rightItem : UIButton? {
        didSet {
            if let item = rightItem {
                rightItems = [item]
            }else {
                rightItems = nil
            }
        }
    }
    
    var backgroundImage : UIImage? {
        didSet {
            self.isTranslucent = false
            self.blurBackgroundView.contentView.layer.contents = backgroundImage
        }
    }
    
    var hiddenLine : Bool = false {
        didSet {
            bottomLine.isHidden = hiddenLine
        }
    }
    
    var isTranslucent : Bool = false {
        didSet {
            if isTranslucent {
                self.blurBackgroundView.contentView.backgroundColor = nil
            }else {
                self.blurBackgroundView.contentView.backgroundColor = UIColor(gray: 249)
            }
        }
    }
    
    override var backgroundColor: UIColor? {
        didSet {
            self.blurBackgroundView.contentView.backgroundColor = backgroundColor
        }
    }
    
    private(set) lazy var titleLabel : UILabel = {
        let l = UILabel()
        l.numberOfLines = 0
        l.textAlignment = .center
        l.font = UIFont.systemFont(ofSize: 18)
        let color: UIColor
        if #available(iOS 13.0, *) {
            color = .label
        }else {
            color = .black
        }
        l.textColor = color
        return l
    }()
    private var bottomLine : UIView!
    private var leftBox : UIView!
    private var rightBox : UIView!
    private var blurBackgroundView : UIVisualEffectView!
    private var leftBoxWidth: CGFloat = 0
    private var rightBoxWidth: CGFloat = 0
    private var leftPadding: CGFloat = 15
    private var rightPadding: CGFloat = 15
    private var titleViewWidth: CGFloat!
    private var titleMaxWidth: CGFloat {
        let half = frame.size.width / 2
        let result = min(half - leftBoxWidth - leftPadding, half - rightBoxWidth - rightPadding)
        return max(0, result*2)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        leftBox = UIView()
        rightBox = UIView()
        let style: UIBlurEffect.Style
        if #available(iOS 10.0, *) {
            style = .prominent
        }else {
            style = .light
        }
        blurBackgroundView = UIVisualEffectView(effect: UIBlurEffect(style: style))
        titleViewWidth = titleMaxWidth
        bottomLine = UIView()
        let color: UIColor
        if #available(iOS 13.0, *) {
            color = .secondaryLabel
        }else {
            color = .darkGray
        }
        bottomLine.backgroundColor = color
        addSubview(blurBackgroundView)
        blurBackgroundView.contentView.addSubviews([leftBox, rightBox, bottomLine])
        blurBackgroundView.snp_makeConstraints { (make) in
            make.edges.equalTo(0)
        }
        bottomLine.snp_makeConstraints { (make) in
            make.left.right.bottom.equalTo(0)
            make.height.equalTo(0.5)
        }
        leftBox.snp_makeConstraints { (make) in
            make.left.equalTo(15)
            make.bottom.equalTo(0)
            make.width.equalTo(0)
            make.height.equalTo(44)
        }
        rightBox.snp_makeConstraints { (make) in
            make.right.equalTo(-leftPadding)
            make.bottom.equalTo(0)
            make.width.equalTo(0)
            make.height.equalTo(44)
        }
        
    }
    
    func updateTitleWidth() {
        ///新增左右Item时，更新titleView的宽度
        self.titleViewWidth = min(self.titleMaxWidth, self.titleViewWidth)
        titleView?.snp_updateConstraints { (m) in
            m.width.equalTo(self.titleViewWidth)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

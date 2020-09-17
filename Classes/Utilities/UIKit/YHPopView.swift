//
//  YHPopView.swift
//  YHKit-Swift
//
//  Created by Champion Fu on 2020/9/15.
//  Copyright © 2020 Champion Fu. All rights reserved.
//

import UIKit

class YHPopView: UIView {
    
    // 自定义内容视图
    private(set) var contentView: UIView? = nil
    
    // 内容视图的尺寸 ，如果子类重写了layouCcontentView,则此属性无效
    private(set) var contentSize: CGSize? = nil
    
    // 动画时长
    var animationDuration: TimeInterval = 0.3
    
    // 遮罩颜色
    var maskColor: UIColor = UIColor.black.withAlphaComponent(0.5)
    
    // 是否点击空白处 dismiss
    var shouldHideOnBlank: Bool = true
    
    var bgView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        bgView = UIView(frame: frame)
        bgView.backgroundColor = maskColor
        contentView = addedContentView()
        contentSize = addedContentSize()
        initialState()
        addSubviews([bgView, contentView!])
        bgView.snp_makeConstraints { (m) in
            m.edges.equalTo(0)
        }
        layoutContentView()
        // event
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismiss(_:)))
        bgView.addGestureRecognizer(tap)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func show(_ completion: (()->())? = nil) {
        isHidden = false
        showAnimation(completion)
    }
    
    /// 初始化属性 可以让子类重写
    func initialState() {
        isHidden = true
        bgView.alpha = 0
        contentView?.alpha = 0
        contentView?.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
    }
    
    /// 供子类重写显示动画
    func showAnimation(_ completion: (()->())? = nil) {
        UIView.animate(withDuration: animationDuration, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 20, options: .curveLinear, animations: {
            self.bgView.alpha = 1
            self.contentView?.alpha = 1
            self.contentView?.transform = CGAffineTransform.identity
        }, completion: { _ in
            completion?()
        })
    }
    
    @objc func dismiss(_ completion: (()->())? = nil) {
        let duration = self.animationDuration
        self.dismissAnimation()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime(floatLiteral: duration)) {
            self.isHidden = true
            completion?()
        }
    }
    
    /// 供子类重写消失
    func dismissAnimation() {
        UIView.animate(withDuration: animationDuration, animations: {
            self.bgView.alpha = 0
            self.contentView?.alpha = 0
            self.contentView?.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        }, completion: nil)
    }
    
    
    
    /// 供子类重写
    func addedContentView() -> UIView? {
        return nil
    }
    
    /// 供子类重写
    func addedContentSize() -> CGSize? {
        return nil
    }
    
    /// 供子类重写
    func layoutContentView() {
        contentView?.snp_makeConstraints({ (m) in
            m.center.equalTo(CGPoint(x: UIScreen.width / 2, y: UIScreen.height / 2))
            m.size.equalTo(contentSize ?? .zero)
        })
    }
}



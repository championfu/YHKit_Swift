//
//  UIView.swift
//  YHKit-Swift
//
//  Created by Champion Fu on 2020/9/14.
//  Copyright © 2020 Champion Fu. All rights reserved.
//

import UIKit

extension UIView {
    
    convenience init(bgColor: UIColor) {
        self.init()
        backgroundColor = bgColor
    }
    
    /**
     除了第一个参数，其他参数都有可能为空
     */
    func linearAutoLayout(subviews subv:[UIView], heights:[CGFloat] = [], tops:[CGFloat] = [], lefts:[CGFloat] = [], rights:[CGFloat] = [], height:CGFloat = 0, top:CGFloat = 0, left:CGFloat = 0, right:CGFloat = 0, superWidth:CGFloat = UIScreen.width) {
        assert(heights.count != 0 || height != 0.0, "高度参数设置出错")
        func realValue(_ value:CGFloat, _ array:[CGFloat], _ index:Int) -> CGFloat{
            return array.count == 0 ? value : array[index]
        }
        for (index, element) in subv.enumerated(){
            let h = realValue(height, heights, index)
            let t = realValue(top, tops, index)
            let l = realValue(left, lefts, index)
            let r = realValue(right, rights, index)
            if index == 0 {
                element.snp_makeConstraints { (make) in
                    make.left.equalTo(l)
                    make.top.equalTo(t)
                    make.width.equalTo(superWidth - l - r)
                    make.height.equalTo(h)
                }
            } else {
                let lastView = subv[index - 1]
                element.snp_makeConstraints { (make) in
                    make.left.equalTo(l)
                    make.top.equalTo(lastView.snp_bottom).offset(t)
                    make.width.equalTo(superWidth - l - r)
                    make.height.equalTo(h)
                }
            }
        }
    }
    
    func linearFrameLayout(subviews subv:[UIView], heights:[CGFloat] = [], tops:[CGFloat] = [], lefts:[CGFloat] = [], rights:[CGFloat] = [], height:CGFloat = 0, top:CGFloat = 0, left:CGFloat = 0, right:CGFloat = 0, superWidth:CGFloat = UIScreen.main.bounds.width) {
        assert(heights.count != 0 || height != 0.0, "高度参数设置出错")
        func realValue(_ value:CGFloat, _ array:[CGFloat], _ index:Int) -> CGFloat{
            return array.count == 0 ? value : array[index]
        }
        var deltTop:CGFloat = 0.0
        for (index, element) in subv.enumerated(){
            let h = realValue(height, heights, index)
            let t = realValue(top, rights, index)
            let l = realValue(left, lefts, index)
            let r = realValue(right, rights, index)
            element.frame = CGRect(x: l, y: t + deltTop, width: superWidth - l - r, height: h)
            deltTop = element.frame.maxY
        }
    }
    
    func controller() -> UIViewController? {
        
        var nextResponse = self.next
        while nextResponse != nil && !(nextResponse is UIViewController) {
            nextResponse = nextResponse!.next
        }
        if let ns = nextResponse as? UIViewController {
            return ns
        }
        return nil
    }
    
    func removeSubviews(_ sub: [UIView]) {
        for (_, v) in sub.enumerated() {
            if v.isDescendant(of: self) {
                v.removeFromSuperview()
            }
        }
    }
    
    func removeAllSubviews() {
        for (_, v) in self.subviews.enumerated() {
            v.removeFromSuperview()
        }
    }
    
    func addSubviews(_ sub: [UIView]) {
        sub.forEach({ addSubview($0) })
    }
    
    enum YHLineDirection {
        case top, bottom, left, right
        func lineConstrains(maker: ConstraintMaker) -> [ConstraintMakerExtendable] {
            switch self {
            case .top:
                return [maker.top, maker.left, maker.right, maker.height]
            case .bottom:
                return [maker.bottom, maker.left, maker.right, maker.height]
            case .left:
                return [maker.left, maker.top, maker.bottom, maker.width]
            default:
                return [maker.right, maker.top, maker.bottom, maker.width]
            }
        }
    }
    func addLine(dire: YHLineDirection, padding: CGPoint = .zero, lineWidth: CGFloat = 0.5, color: UIColor = UIColor(hex: "cccccc"), offset: CGFloat = 0) -> UIView {
        let line = UIView(bgColor: color)
        self.addSubview(line)
        
        line.snp_makeConstraints { (make) in
            let cs = dire.lineConstrains(maker: make)
            cs[0].equalTo(offset)
            cs[1].equalTo(padding.x)
            cs[2].equalTo(-padding.y)
            cs[3].equalTo(lineWidth)
        }
        return line
    }
    
    func addCorner(_ radius: CGFloat, _ width: CGFloat = 0, _ color: UIColor = .black) {
        ///如果是UIView，可以不设置clipToBounds，这样就可以添加阴影了
        if !self.isMember(of: UIView.self) {
            clipsToBounds = true
        }
        layer.cornerRadius = radius
        layer.borderColor = color.cgColor
        layer.borderWidth = width
    }
    
    
    
}

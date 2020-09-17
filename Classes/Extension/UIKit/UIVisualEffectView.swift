//
//  UIVisualEffectView.swift
//  YHKit-Swift
//
//  Created by Champion Fu on 2020/9/15.
//  Copyright © 2020 Champion Fu. All rights reserved.
//

import UIKit

extension UIVisualEffectView {
    static func defaultBlurView() -> UIVisualEffectView {
        let style: UIBlurEffect.Style
        if #available(iOS 10.0, *) {
            style = .prominent
        }else {
            style = .light
        }
        return UIVisualEffectView(style: style)
    }
    
    convenience init(style: UIBlurEffect.Style) {
        self.init(effect: UIBlurEffect(style: style))
    }
}

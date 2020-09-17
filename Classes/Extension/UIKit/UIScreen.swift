//
//  UIScreen.swift
//  YHKit-Swift
//
//  Created by Champion Fu on 2020/9/15.
//  Copyright © 2020 Champion Fu. All rights reserved.
//

import UIKit

extension UIScreen {
    
    static var width: CGFloat { UIScreen.main.bounds.width }
    static var height: CGFloat { UIScreen.main.bounds.height }
    static var size: CGSize { UIScreen.main.bounds.size }
    
    ///安全区域
    static var topSafeHeight: CGFloat { UIApplication.shared.statusBarFrame.size.height }
    static var naviBarHeight: CGFloat { topSafeHeight + 44 }
    static var bottomSafeHeight: CGFloat { topSafeHeight == 20 ? 0 : 34 }
    static var pixelScale: CGFloat { 1 / UIScreen.main.scale }
    ///相比于iphone6的宽度比例
    static var wRatio: CGFloat { width / 375.0 }
    ///相比于iphone6的高度比例
    static var hRatio: CGFloat { height / 667.0 }
}

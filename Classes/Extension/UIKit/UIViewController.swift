//
//  UIViewController.swift
//  YHKit-Swift
//
//  Created by Champion Fu on 2020/9/15.
//  Copyright © 2020 Champion Fu. All rights reserved.
//

import UIKit

extension UIViewController {
    func push(dest: UIViewController, animated: Bool = true) {
        
        if let navi = self as? UINavigationController {
            navi.pushViewController(dest, animated: animated)
        }
        
        if let navi = self.navigationController {
            navi.pushViewController(dest, animated: animated)
        }
    }
    
    
    @objc
    func pop(src: UIViewController? = nil, animated: Bool = true) -> UIViewController? {
        if  let navi = self as? UINavigationController, navi.viewControllers.count > 1 {
            if let src = src {
                if navi.viewControllers.contains(src) {
                    _ = navi.popToViewController(src, animated: animated)
                    return src
                }else {
                    return nil
                }
            }else {
                let count = navi.viewControllers.count
                _ = navi.popViewController(animated: animated)
                return navi.viewControllers[count - 2]
            }
        }
        
        if let navi = self.navigationController, navi.viewControllers.count > 1 {
            if let src = src {
                if navi.viewControllers.contains(src) {
                    _ = navi.popToViewController(src, animated: animated)
                    return src
                }else {
                    return nil
                }
            }else {
                let count = navi.viewControllers.count
                _ = navi.popViewController(animated: animated)
                return navi.viewControllers[count - 2]
            }
        }
        return nil
    }
    
    func popToTop(animated: Bool = true) -> UIViewController? {
        if let navi = self as? UINavigationController, navi.viewControllers.count > 1 {
            navi.popToRootViewController(animated: animated)
            return navi.viewControllers.first
        }
        
        if let navi = self.navigationController, navi.viewControllers.count > 1 {
            navi.popToRootViewController(animated: animated)
            return navi.rootViewController
        }
        
        return nil
    }
    
    
    ///回跳步数
    func pop(withStep step: Int, animated: Bool = true) -> UIViewController? {
        
        if let navi = self as? UINavigationController {
            let index = navi.viewControllers.count - 1  - step
            if index >= 0 && step > 0 {
                let dest = navi.viewControllers[index]
                return pop(src: dest, animated: animated)
            }
            return nil
        }
        
        if let navi = self.navigationController {
            let index = navi.viewControllers.count - 1  - step
            if index >= 0 && step > 0 {
                let dest = navi.viewControllers[index]
                return pop(src: dest, animated: animated)
            }
            return nil
        }
        return nil
    }
    
    func sibling(offset index: Int = 1) -> UIViewController? {
        if let parent = parent, parent.children.count > 1, index >= 1 {
            if let i = parent.children.firstIndex(of: self), i >= index {
                return parent.children[i - index]
            }else {
                return nil
            }
        }else {
            return nil
        }
    }
}

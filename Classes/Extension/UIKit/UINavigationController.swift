//
//  UINavigationController.swift
//  YHKit-Swift
//
//  Created by Champion Fu on 2020/9/15.
//  Copyright © 2020 Champion Fu. All rights reserved.
//

import UIKit

extension UINavigationController {
    var rootViewController: UIViewController? {
        return self.viewControllers.first
    }
}

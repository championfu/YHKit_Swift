//
//  UITabBarController.swift
//  YHKit-Swift
//
//  Created by Champion Fu on 2020/9/15.
//  Copyright © 2020 Champion Fu. All rights reserved.
//

import UIKit

extension UITabBarController {
    @objc func addChildControllers(_ controllers: [UIViewController], titles: [String], normalImages:[UIImage], selectedImages: [UIImage]) {
        for (index, vc) in controllers.enumerated() {
            let tabBarItem = UITabBarItem(title: titles[index], image: normalImages[index], selectedImage: selectedImages[index])
            vc.tabBarItem = tabBarItem
            self.addChild(vc)
        }
        
    }
}

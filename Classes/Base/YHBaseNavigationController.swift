//
//  YHBaseNavigationController.swift
//  YHKit-Swift
//
//  Created by Champion Fu on 2020/9/15.
//  Copyright © 2020 Champion Fu. All rights reserved.
//

import UIKit

class YHBaseNavigationController: UINavigationController {    

    override func viewDidLoad() {
        super.viewDidLoad()
        baseInit()
    }
    
    func baseInit() {
        
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }

}

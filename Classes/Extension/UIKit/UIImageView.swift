//
//  UIImageView.swift
//  YHKit-Swift
//
//  Created by Champion Fu on 2020/9/15.
//  Copyright © 2020 Champion Fu. All rights reserved.
//

import UIKit

extension UIImageView {
    convenience init(named imageName: String) {
        self.init(image: UIImage(named: imageName))
    }
}

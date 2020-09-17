//
//  UITableViewCell.swift
//  YHKit-Swift
//
//  Created by Champion Fu on 2020/9/15.
//  Copyright © 2020 Champion Fu. All rights reserved.
//

import UIKit

extension UITableViewCell {
    var tableView: UITableView? {
        var sp: UIView? = superview
        while sp != nil {
            if sp is UITableView {
                return sp as? UITableView
            }
            sp = sp?.superview
        }
        return nil
    }
}

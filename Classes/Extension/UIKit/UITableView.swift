//
//  UITableView.swift
//  YHKit-Swift
//
//  Created by Champion Fu on 2020/9/15.
//  Copyright © 2020 Champion Fu. All rights reserved.
//

import UIKit

private var associateKey: Void?
extension UITableView {
    
    typealias TableViewProtocol = AnyObject & UITableViewDelegate & UITableViewDataSource
    
    var reuseIdentifiers: [String] {
        set{
            objc_setAssociatedObject(self, &associateKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get{
            objc_getAssociatedObject(self, &associateKey) as! [String]
        }
    }
    
    @objc
    
    convenience init(delegate:TableViewProtocol, cellClass:AnyClass, frame:CGRect = CGRect.zero, style:UITableView.Style = .plain){
        self.init(delegate: delegate, cellClasses: [cellClass], frame: frame, style: style)
    }
    
    @objc
    convenience init(delegate:TableViewProtocol, cellClasses:[AnyClass], frame:CGRect = CGRect.zero ,style:UITableView.Style = .plain){
        self.init(frame:frame, style:style)
        self.reuseIdentifiers = []
        self.tableFooterView = UIView()
        self.register(cellClses: cellClasses)
        self.delegate = delegate
        self.dataSource = delegate
    }
    
    @objc
    func register(cellClses:[AnyClass]) {
        
        cellClses.forEach({
            if !reuseIdentifiers.contains($0.description()) {
                register($0, forCellReuseIdentifier: $0.description())
                reuseIdentifiers.append($0.description())
            }
        })
    }
    
    @objc func register(system identifiers: [String]) {
        identifiers.forEach({
            if !reuseIdentifiers.contains($0) {
                register(UITableViewCell.self, forCellReuseIdentifier: $0)
                reuseIdentifiers.append($0)
            }
        })
    }
    
    @objc
    func dequeueReusableCell(at index: Int = 0) -> UITableViewCell?{
        if index >= 0 && index < reuseIdentifiers.count {
            return dequeueReusableCell(withIdentifier: reuseIdentifiers[index])
        }else {
            return nil
        }
    }
    
    /**
     0、不带副标题 1、正副标题左右结构，分散显示（大部分情况）2、正副标题左右结构，居中显示 3、正副标题上下结构
     */
    @objc
    func systemReuseableCell(at index: Int = 0, style: UITableViewCell.CellStyle = .default) -> UITableViewCell? {
        if index >= 0 && index < reuseIdentifiers.count {
            return UITableViewCell(style: style, reuseIdentifier: reuseIdentifiers[index])
        }else {
            return nil
        }
    }
    
}

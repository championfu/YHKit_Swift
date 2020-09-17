//
//  UICollectionView.swift
//  YHKit-Swift
//
//  Created by Champion Fu on 2020/9/15.
//  Copyright © 2020 Champion Fu. All rights reserved.
//

import UIKit

private var associateKey: Void?
extension UICollectionView {
    
    typealias UICollectViewProtocol = AnyObject & UICollectionViewDelegate & UICollectionViewDataSource
    
    private var reuseIdentifiers : [String]{
        set{
            objc_setAssociatedObject(self, &associateKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get{
            return objc_getAssociatedObject(self, &associateKey) as! [String]
        }
    }
    
    @objc convenience init(delegate: UICollectViewProtocol?, cellClass: AnyClass, itemSize: CGSize, rowSpace: CGFloat = 0, columSpace: CGFloat = 0, inset: UIEdgeInsets = UIEdgeInsets.zero, direct: UICollectionView.ScrollDirection = .vertical, frame: CGRect = .zero) {
        self.init(delegate: delegate, cellClasses: [cellClass], itemSize: itemSize, rowSpace: rowSpace, columSpace: columSpace, inset: inset, direct: direct, frame: frame)
    }
    
    @objc convenience init(delegate: UICollectViewProtocol?, cellClasses: [AnyClass], itemSize: CGSize, rowSpace: CGFloat = 0, columSpace: CGFloat = 0, inset: UIEdgeInsets = UIEdgeInsets.zero, direct: UICollectionView.ScrollDirection = .vertical, frame: CGRect = .zero) {
        let layout = UICollectionViewFlowLayout(itemSize: itemSize, rowSpace: rowSpace, columSpace: columSpace, inset: inset, direct: direct)
        self.init(frame: frame, collectionViewLayout:layout)
        self.delegate = delegate
        self.dataSource = delegate
        self.register(cellClasses: cellClasses)
        if #available(iOS 13.0, *) {
            backgroundColor = .systemBackground
        } else {
            backgroundColor = .white
        }
    }
    
    @objc convenience init(delegate: UICollectViewProtocol?, cellClass: AnyClass, layout: UICollectionViewLayout, frame: CGRect = .zero) {
        self.init(delegate: delegate, cellClasses: [cellClass], layout: layout, frame: frame)
    }
    @objc convenience init(delegate: UICollectViewProtocol?, cellClasses: [AnyClass], layout: UICollectionViewLayout, frame: CGRect = .zero) {
        self.init(frame: frame, collectionViewLayout: layout)
        self.delegate = delegate
        self.dataSource = delegate
        self.reuseIdentifiers = []
        self.register(cellClasses: cellClasses)
        if #available(iOS 13.0, *) {
            backgroundColor = .systemBackground
        } else {
            backgroundColor = .white
        }
    }
    
    
    @objc func register(cellClasses: [AnyClass]) {
        cellClasses.forEach({
            if !reuseIdentifiers.contains($0.description()) {
                register($0, forCellWithReuseIdentifier: $0.description())
                reuseIdentifiers.append($0.description())
            }
        })
    }
    
    @objc func register(system identifiers: [String]) {
        identifiers.forEach({
            if !reuseIdentifiers.contains($0) {
                register(UICollectionViewCell.self, forCellWithReuseIdentifier: $0)
                reuseIdentifiers.append($0)
            }
        })
    }
    
    @objc func dequeueReuseableCell(at index: Int = 0, for indexPath: IndexPath) -> UICollectionViewCell?{
        if index >= 0 && index < reuseIdentifiers.count {
            return dequeueReusableCell(withReuseIdentifier: reuseIdentifiers[index], for: indexPath)
        }else {
            return nil
        }
    }
    
}

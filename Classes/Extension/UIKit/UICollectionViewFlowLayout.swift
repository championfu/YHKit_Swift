//
//  UICollectionViewFlowLayout.swift
//  YHKit-Swift
//
//  Created by Champion Fu on 2020/9/15.
//  Copyright © 2020 Champion Fu. All rights reserved.
//

import UIKit

extension UICollectionViewFlowLayout {
    
    convenience init(itemSize: CGSize, rowSpace: CGFloat = 0, columSpace: CGFloat = 0, inset: UIEdgeInsets = .zero, direct: UICollectionView.ScrollDirection = .vertical) {
        self.init()
        self.itemSize = itemSize
        minimumLineSpacing = rowSpace
        minimumInteritemSpacing = columSpace
        sectionInset = inset
        scrollDirection = direct
    }
    
}


//
//  YHHorizontalFlowLayout.swift
//  YHKit-Swift
//
//  Created by Champion Fu on 2020/9/15.
//  Copyright © 2020 Champion Fu. All rights reserved.
//

import UIKit

class YHHorizontalFlowLayout: UICollectionViewFlowLayout {
    
    enum FlowLayoutAlignType {
        case left, right
    }
    
    private var alignType: FlowLayoutAlignType = .left
    
    convenience init(_ alignType: FlowLayoutAlignType) {
        self.init()
        self.alignType = alignType
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let attrs = super.layoutAttributesForElements(in: rect) else {
            return nil
        }
        if alignType == .left {
            for i in 0..<attrs.count {
                let attr = attrs[i]
                var frame = attr.frame
                if i > 0 {
                    let preFrame = attrs[i - 1].frame
                    //调整同一排的cell的位置
                    if preFrame.origin.y == frame.origin.y {
                        frame.origin.x = preFrame.maxX + self.minimumInteritemSpacing
                    }else {
                        //靠左边
                        frame.origin.x = self.sectionInset.left
                    }
                }else {
                    frame.origin.x = self.sectionInset.left
                }
                attr.frame = frame
            }
        }else {
            for i in (0..<attrs.count).reversed() {
                let attr = attrs[i]
                var frame = attr.frame
                if i < attrs.count - 1 {
                    let lastFrame = attrs[i+1].frame
                    //调整同一排的cell的位置
                    if frame.origin.y == lastFrame.origin.y {
                        frame.origin.x = lastFrame.origin.x - frame.width - minimumInteritemSpacing
                    }else {
                        //靠右边
                        frame.origin.x = rect.width - frame.width - sectionInset.right
                    }
                }else {
                    frame.origin.x = rect.width - frame.width - sectionInset.right
                }
                attr.frame = frame
            }
        }
        return attrs
    }
    
    
}


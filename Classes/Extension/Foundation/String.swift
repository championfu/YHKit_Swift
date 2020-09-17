//
//  String.swift
//  YHKit-Swift
//
//  Created by Champion Fu on 2020/9/15.
//  Copyright © 2020 Champion Fu. All rights reserved.
//

import UIKit

extension String {
    
    private func stringSize(_ string: NSString, _ size: CGSize, _ font: UIFont) -> CGSize {
        let attributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font:font]
        return string.boundingRect(with: size, options: [.usesLineFragmentOrigin,.usesFontLeading], attributes: attributes, context: nil).size
    }
    
    func width(_ font: UIFont) -> CGFloat {
        stringSize((self as NSString), CGSize(width: CGFloat.infinity, height: CGFloat.infinity), font).width
    }
    
    func height(_ font: UIFont, _ width: CGFloat) -> CGFloat {
        stringSize((self as NSString), CGSize(width: width, height: CGFloat.infinity), font).height
    }
    ///解决URL含中文的问题
    func urlEncoded() -> String {
        addingPercentEncoding(withAllowedCharacters: CharacterSet(charactersIn: "!$&'()*+,-./:;=?@_~%#[]")) ?? ""
    }
    
}

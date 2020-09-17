//
//  Functions.swift
//  YHKit-Swift
//
//  Created by Champion Fu on 2020/9/14.
//  Copyright © 2020 Champion Fu. All rights reserved.
//

import UIKit


func RGB(_ r:CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat = 1) -> UIColor {
    return UIColor(red: r / CGFloat(255), green: g / CGFloat(255), blue: b / CGFloat(255), alpha: a)
}

func GRAY(_ v: CGFloat) -> UIColor {
    return RGB(v, v, v)
}

func HEX(_ hex: String) -> UIColor {
    return UIColor(hex: hex)
}

@inlinable func clamp<T>(_ v: T, _ up: T, _ low: T) -> T where T : Comparable {
    min(max(v, low), up)
}

func randomInt(between a: Int, b: Int) -> Int {
    return a + Int(arc4random_uniform(UInt32(b - a)))
}

func randomInt(in a: Int) -> Int {
    Int(arc4random_uniform(UInt32(a)))
}

func randomFloat(between a: CGFloat, b: CGFloat) -> CGFloat {
    return a + CGFloat(arc4random_uniform(UInt32(b - a)))
}

func randomFloat(in a: CGFloat) -> CGFloat {
    CGFloat(arc4random_uniform(UInt32(a)))
}

func checkInput(_ bools: [Bool], _ msgs: [String]) -> String? {
    assert(bools.count > 0 && bools.count == msgs.count)
    for (index, bool) in bools.enumerated() {
        let msg = msgs[index]
        if !bool {
            return msg
        }
    }
    return nil
}

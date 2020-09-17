//
//  SwiftGlobalVariables.swift
//  ShangLian
//
//  Created by Champion Fu on 2019/8/22.
//  Copyright © 2019 Champion Fu. All rights reserved.
//

import Foundation
//import RealmSwift

let YHGlobal = SwiftGlobal()

class SwiftGlobal {
    
}

public final class Namespace<Base> {
    let base: Base
    init(_ base: Base) {
        self.base = base
    }
}


protocol NamespaceCompatible {
    associatedtype CompatibleType
    var yh: CompatibleType { get }
    static var yh: CompatibleType.Type { get }
}

extension NamespaceCompatible {
    var yh: Namespace<Self> {
        return Namespace(self)
    }
    static var yh: Namespace<Self>.Type {
        return Namespace<Self>.self
    }
}



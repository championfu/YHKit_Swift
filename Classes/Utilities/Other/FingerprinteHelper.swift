//
//  File.swift
//  Manhua
//
//  Created by Champion Fu on 2020/9/5.
//  Copyright © 2020 Champion Fu. All rights reserved.
//

import LocalAuthentication

class FingerprintHelper {
    
    ///context是一个系统全局变量
    private static let context: LAContext = LAContext()
    
    static func isEnable() -> Bool {
        if #available(iOS 9.0, *) {
            return context.canEvaluatePolicy(.deviceOwnerAuthentication, error: nil)
        }else {
            return context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
        }
    }
    
    static func evaluate(_ completion: @escaping (Bool)->Void, _ reason: String = "用于应用锁解锁") {
        context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { (isSuccess, error) in
            if error == nil {
                completion(isSuccess)
            }else {
                if (error! as NSError).code == -3 {
                    context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) { (isSuccess1, error1) in
                        if error1 == nil {
                            completion(isSuccess1)
                        }else {
                            completion(false)
                        }
                    }
                }else {
                    completion(false)
                }
            }
        }
    }
    
}

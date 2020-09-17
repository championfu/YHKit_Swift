//
//  UIAlertController.swift
//  YHKit-Swift
//
//  Created by Champion Fu on 2020/9/15.
//  Copyright © 2020 Champion Fu. All rights reserved.
//

//不在为iOS8以下的系统做适配了
import UIKit

struct AlertActionAttributes {
    let title: String?
    let titleColor: UIColor?
    let image: UIImage?
    init(title: String?, titleColor: UIColor?, image: UIImage? = nil) {
        self.title = title
        self.titleColor = titleColor
        self.image = image
    }
}

extension UIAlertController {
    
    typealias AlertActionBlock = ((_ buttonIndex: Int, _ action: UIAlertAction) -> ())
    
    /**
     alert 2个按钮及以下排序<从左往右>升序，两个以上<从下往上>升序
     actionSheet <从上往下>升序
     */
    
    convenience init(_ title: Any?, _ message: Any?, _ actionTitles: [Any], _ style: UIAlertController.Style, _ clickBlock: AlertActionBlock? = nil) {
        self.init(title: "", message: "", preferredStyle: style)
        if title is String || title == nil {
            self.title = (title as? String) ?? ""
        }else {
            self.setValue(title, forKey: "attributedTitle")
        }
        if message is String || message == nil{
            self.message = (message as? String) ?? ""
        }else {
            self.setValue(message, forKey: "attributedMessage")
        }
        
        for i in 0..<actionTitles.count {
            let actionTitle = actionTitles[i]
            let alertAction = UIAlertAction(title: "", style: .default) { (action) in
                if clickBlock != nil {
                    clickBlock!(i, action)
                }
            }
            if actionTitle is String {
                alertAction.setTitle(actionTitle as! String)
            }else {
                alertAction.setAlertAttributes(actionTitle as! AlertActionAttributes)
            }
            self.addAction(alertAction)
        }
        
    }
    
    
    static func showAlert(_ title: Any?, _ message: Any?, _ actionTitles: [Any], _ presentViewController: UIViewController? = nil, _ clickBlock: AlertActionBlock? = nil) -> UIAlertController{
        let alertController = UIAlertController(title, message, actionTitles, .alert, clickBlock)
        let rootController = UIApplication.shared.keyWindow?.rootViewController
        let pvc = presentViewController == nil ? rootController : presentViewController
        pvc?.present(alertController, animated: true, completion: nil)
        return alertController
    }
    
    static func showAlert(_ title: Any?, _ message: Any?, _ actionTitles: [Any], _ clickBlock: AlertActionBlock? = nil) -> UIAlertController {
        return showAlert(title, message, actionTitles, nil, clickBlock)
    }
    
    static func showSheet(_ title: Any?, _ message: Any?, _ actionTitles: [Any], _ presentViewController: UIViewController? = nil, _ clickBlock: AlertActionBlock? = nil) -> UIAlertController{
        let alertController = UIAlertController(title, message, actionTitles, .actionSheet, clickBlock)
        let rootController = UIApplication.shared.keyWindow?.rootViewController
        let pvc = presentViewController == nil ? rootController : presentViewController
        pvc?.present(alertController, animated: true, completion: nil)
        return alertController
    }
    
    static func showSheet(_ title: Any?, _ message: Any?, _ actionTitles: [Any], _ clickBlock: AlertActionBlock? = nil) -> UIAlertController {
        return showSheet(title, message, actionTitles, nil, clickBlock)
    }
    
    func show(_ presentViewController: UIViewController? = nil, hiddenAfter delay: TimeInterval = 0, completion: (()->())? = nil) {
        let rootController = UIApplication.shared.keyWindow?.rootViewController
        let pvc = presentViewController == nil ? rootController : presentViewController
        pvc?.present(self, animated: true, completion: nil)
        if delay != 0 {
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                self.dismiss(animated: true, completion: completion)
            }
        }
    }
    
    func dissmiss(after delay: TimeInterval = 0, completion: (()->())? = nil) {
        if delay != 0 {
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                self.dismiss(animated: true, completion: completion)
            }
        }else {
            self.dismiss(animated: true, completion: completion)
        }
    }
    
}

extension UIAlertAction {
    
    convenience init(attributes: AlertActionAttributes, handler: ((UIAlertAction) -> Void)? = nil) {
        self.init(title: "", style: .default, handler: handler)
        setAlertAttributes(attributes)
    }
    
    var textColor: UIColor? {
        set {
            self.setValue(newValue, forKeyPath: "titleTextColor")
        }
        get {
            self.value(forKeyPath: "titleTextColor") as? UIColor
        }
    }
    
    var image: UIImage? {
        set {
            self.setValue(newValue, forKeyPath: "image")
        }
        get {
            self.value(forKeyPath: "image") as? UIImage
        }
    }
    
    func setTitle(_ title: String) {
        self.setValue(title, forKeyPath: "title")
    }
    
    func setAlertAttributes(_ attr: AlertActionAttributes){
        self.setValue(attr.title, forKeyPath: "title")
        self.setValue(attr.titleColor, forKeyPath: "titleTextColor")
        self.setValue(attr.image, forKeyPath: "image")
    }
    
}

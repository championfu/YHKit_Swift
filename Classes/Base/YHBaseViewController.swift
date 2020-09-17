//
//  YHBaseViewController.swift
//  YHKit-Swift
//
//  Created by Champion Fu on 2020/9/15.
//  Copyright © 2020 Champion Fu. All rights reserved.
//

import UIKit

enum YHNaviBarStyle {
    case color, image, translucent
}

@objc(YHBaseViewController)
class YHBaseViewController: UIViewController {
    
    lazy var navigationBar : YHNavigationBar = {
        return YHNavigationBar(frame: CGRect(x: 0, y: 0, width: UIScreen.width, height: UIScreen.naviBarHeight))
    }()
    
    /**
     *所有请求id
     */
    var requestIdArray: [String?] = []
    
    var observerArray: [NSObjectProtocol?] = []
    
    func addBackButton() {
        let arrowImage: UIImage
        if #available(iOS 13.0, *) {
            arrowImage = UIImage(systemName: "chevron.left", pointSize: 40)!
        }else {
            
            arrowImage = UIImage()
        }
        let backButton = UIButton(imageButton: arrowImage)
        backButton.frame = CGRect(x: 0, y: 0, width: 50, height: 44)
        backButton.contentHorizontalAlignment = .left
        backButton.addTarget(self, action: #selector(pop(src:animated:)), for: .touchUpInside)
        navigationBar.leftItem = backButton
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        baseInit()
        initUI()
        eventHandle()
        loadData()
    }
    
    @objc func baseInit() {
        let color: UIColor
        if #available(iOS 13.0, *) {
            color = .secondarySystemBackground
        }else {
            color = UIColor(gray: 0xfa)
        }
        self.view.backgroundColor = color
//        self.fd_prefersNavigationBarHidden = true
        view.addSubview(navigationBar)
        navigationBar.snp_makeConstraints { (make) in
            make.left.top.right.equalTo(0)
            make.height.equalTo(UIScreen.naviBarHeight)
        }
        if navigationController?.viewControllers.count ?? 0 > 1 {
            addBackButton()
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.bringSubviewToFront(navigationBar)
    }
    
    
    @objc func initUI() {}
    
    @objc func eventHandle() {}
    
    @objc func loadData() {}
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        ///只对暗黑模式切换的环境特征做监听
        if let preTraits = previousTraitCollection, #available(iOS 13.0, *), preTraits.userInterfaceStyle != traitCollection.userInterfaceStyle {
            NotificationCenter.default.post(name: Notification.Name("userInterfaceStyleDidChanged"), object: traitCollection.userInterfaceStyle.rawValue)
        }
    }
    
    
    deinit {
        observerArray.forEach({ NotificationCenter.default.removeObserver($0) })
    }
}

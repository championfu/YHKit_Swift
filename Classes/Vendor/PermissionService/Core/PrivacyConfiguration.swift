//
//  PrivacyConfiguration.swift
//  ChinaHope
//
//  Created by Champion Fu on 2020/1/7.
//  Copyright © 2020 Champion Fu. All rights reserved.
//

import Foundation


struct MicrophoneMessage: ServiceMessages {
    let restrictedTitle: String = "麦克风被限制使用"
    let restrictedMessage: String = "请确认您的麦克风是否能正常使用"
    let deniedTitle: String = "麦克风被禁止使用"
    let deniedMessage: String = "请跳转到系统隐私设置页面去设置"
}

struct CameraMessage: ServiceMessages {
    let restrictedTitle: String = "相机被限制使用"
    let restrictedMessage: String = "请确认您的相机是否能正常使用"
    var deniedTitle: String = "相机被禁止使用"
    var deniedMessage: String = "请跳转到系统隐私设置页面去设置"
}

struct GalleryMessage: ServiceMessages {
    let restrictedTitle: String = "相册被限制使用"
    let restrictedMessage: String = "请确认您的相册是否能正常打开"
    var deniedTitle: String = "相册被禁止访问"
    var deniedMessage: String = "请跳转到系统隐私设置页面去设置"
}


//
//  UIImage.swift
//  YHKit-Swift
//
//  Created by Champion Fu on 2020/9/15.
//  Copyright © 2020 Champion Fu. All rights reserved.
//

import UIKit
import AVFoundation

extension UIImage {
    /// buffer转Image，在相机录像实时预览中会使用到
    convenience init(_ sampleBuffer: CMSampleBuffer) {
        let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer)!
        CVPixelBufferLockBaseAddress(imageBuffer, .readOnly)
        let baseAddress = CVPixelBufferGetBaseAddress(imageBuffer)
        let bytesPerRow = CVPixelBufferGetBytesPerRow(imageBuffer)
        let width = CVPixelBufferGetWidth(imageBuffer)
        let height = CVPixelBufferGetHeight(imageBuffer)
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo.byteOrder32Little.rawValue | CGImageAlphaInfo.premultipliedFirst.rawValue
        let ctx = CGContext(data: baseAddress, width: width, height: height, bitsPerComponent: 8, bytesPerRow: bytesPerRow, space: colorSpace, bitmapInfo: bitmapInfo)
        let qzImage = ctx?.makeImage()
        CVPixelBufferUnlockBaseAddress(imageBuffer, .readOnly)
        self.init(cgImage: qzImage!)
    }
    
    ///设置透明度
    func translucent(_ alpha: CGFloat) -> UIImage {
        var a = alpha
        a = min(1, a)
        a = max(0, a)
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        let ctx  = UIGraphicsGetCurrentContext()!
        let area = CGRect(x: 0, y: 0, width: size.width, height: size.height)

        ctx.scaleBy(x: 1, y: -1)
        ctx.translateBy(x: 0, y: -area.height)
        ctx.setBlendMode(.multiply)
        ctx.setAlpha(a)
        ctx.draw(cgImage!, in: area)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    ///图片格式
    var format: String? {
        let data = pngData()!
        if let byte = data.first {
            switch byte {
            case 0xff:return "JPEG"
            case 0x89:return "PNG"
            case 0x47:return "GIF"
            case 0x4D,0x49:return "TIFF"
            case 0x52 where data.count >= 12:
                if let str = String(data: data[0...11], encoding: .ascii), str.hasPrefix("RIFF"), str.hasPrefix("WEBP") {
                    return "WebP"
                }
            case 0x00 where data.count >= 12:
                if let str = String(data: data[8...11], encoding: .ascii) {
                    let HEICBitMaps = Set(["heic", "heis", "heix", "hevc", "hevx"])
                    if HEICBitMaps.contains(str) {
                        return "HEIC"
                    }
                    let HEIFBitMaps = Set(["mif1", "msf1"])
                    if HEIFBitMaps.contains(str) {
                        return "HEIF"
                    }
                }
            default: return nil
            }
        }
        return nil
    }
    
    var whRatio: CGFloat {
        if size.height == 0 {
            return 0
        }
        return size.width / size.height
    }
    
    var hwRatio: CGFloat {
        if size.width == 0 {
            return 0
        }
        return size.height / size.width
    }
    
    ///将图片压缩到指定大小
    func compress(to bytes: UInt64) -> Data {
        func stringlizalBytes(_ bt: Int) -> String {
            let units = ["B","KB","MB","GB","TB"]
            for (index, unit) in units.enumerated() {
                if bt < Int(powf(1024, Float(index + 1))) {
                    return String(format: "%.2f\(unit)", CGFloat(bt) / CGFloat(powf(1024, Float(index))))
                }
            }
            return String(format: "%.2fTB", CGFloat(bt) / CGFloat(powf(1024, 4)))
        }
        func KB(_ bytes: Int) -> Int {
            return bytes*1024
        }
        var scale: CGFloat = 0.9
        var data = jpegData(compressionQuality: scale)!
        var oldData = Data()
        while data.count  > bytes {
            scale -= 0.1
            if abs(oldData.count - data.count) < KB(10) || scale < 0 {
                break
            }
            oldData = data
            data = jpegData(compressionQuality: scale) ?? Data()
        }
        print("图片最后的大小为:%@",stringlizalBytes(data.count))
       return data
    }
    
    
    enum GradientDirection {
        
        case horizontal // 水平渐变
        
        case ascDiagonal // 上升对角线渐变
        
        case desDiagonal // 下降对角线渐变
        
        case vertical // 垂直渐变
    }
    
    static func linearGradientImage(with colors: [UIColor], locations: inout [CGFloat], direction: GradientDirection, size: CGSize, path: CGPath? = nil) -> UIImage {
        UIGraphicsBeginImageContext(size)
        
        let ctx = UIGraphicsGetCurrentContext()!
        ctx.scaleBy(x: size.width, y: size.height)
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let cfColors = colors.map({$0.cgColor}) as CFArray
        let gradient: CGGradient = CGGradient(colorsSpace: colorSpace, colors: cfColors, locations: locations)!
        var startPoint: CGPoint
        var endPoint: CGPoint
        switch direction {
        case .horizontal: startPoint = CGPoint(x: 0, y: 0); endPoint = CGPoint(x: 1, y: 0)
        case .ascDiagonal: startPoint = CGPoint(x: 0, y: 1); endPoint = CGPoint(x: 1, y: 0)
        case .desDiagonal: startPoint = CGPoint(x: 0, y: 0); endPoint = CGPoint(x: 1, y: 1)
        case .vertical: startPoint = CGPoint(x: 0, y: 1); endPoint = CGPoint(x: 0, y: 0)
        }
        
        if let path = path {
            ctx.addPath(path)
            ctx.clip()
        }
        
        ctx.drawLinearGradient(gradient, start: startPoint, end: endPoint, options: .drawsBeforeStartLocation)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    
    ///径向渐变
    static func radiaGradientImage(with colors: [UIColor], locations: inout [CGFloat], size: CGSize, path: CGPath? = nil) -> UIImage {
        UIGraphicsBeginImageContext(size)
        let ctx = UIGraphicsGetCurrentContext()!
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let cfColors = colors.map({$0.cgColor}) as CFArray
        let gradient: CGGradient = CGGradient(colorsSpace: colorSpace, colors: cfColors, locations: locations)!
        
        if let path = path {
            ctx.addPath(path)
            ctx.clip()
        }
        let radius = max(size.width / 2, size.height / 2) * sqrt(2.0)
        let center = CGPoint(x: size.width / 2, y: size.height / 2)
        ctx.drawRadialGradient(gradient, startCenter: center, startRadius: 0, endCenter: center, endRadius: radius, options: .drawsBeforeStartLocation)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    enum ImageCorner {
        case none
        case corner(radius: CGFloat)
        case circle
        
    }
    
    static func imageWidth(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) -> UIImage? {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        let ctx = CGContext.current()
        ctx?.setFillColor(color.cgColor)
        ctx?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    @available(iOS 13.0, *)
    convenience init?(systemName: String, pointSize: CGFloat, weight: SymbolWeight = .regular) {
        self.init(systemName :systemName, withConfiguration: UIImage.SymbolConfiguration(pointSize: pointSize, weight: weight))
    }
    
}

//
//  AppResourceManager.swift
//  SwiftUI_Demo1
//
//  Created by anker on 2023/3/22.
//

import UIKit
import SVGKit
class AppResourceManager: NSObject {
    static let shared = AppResourceManager()
    func svgImage(imageName: String, bundlePath: String, relative: String) -> SVGKImage? {
        let imageName = imageName + ".svg"
        let bundlePath = bundlePath + "/" + relative + imageName
        guard FileManager.default.fileExists(atPath: bundlePath),
              let imageBundle = Bundle(path: (bundlePath as NSString).deletingLastPathComponent) else { return nil }
        return SVGKImage(named: imageName , in: imageBundle, withCacheKey: relative + imageName)
    }
    func pngImage(imageName: String, bundlePath: String, relative: String) -> UIImage? {
        guard FileManager.default.fileExists(atPath: bundlePath),
              let imageBundle = Bundle(path: (bundlePath as NSString).deletingLastPathComponent) else { return nil }
        let imagePath = bundlePath + relative + "/" + imageName + ".png"
        let imagePath1x = imagePath + ".png"
        let imagePath2x = imagePath + "@2x.png"
        let imagePath3x = imagePath + "@3x.png"
        guard FileManager.default.fileExists(atPath: imagePath1x) ||
            FileManager.default.fileExists(atPath: imagePath2x) ||
            FileManager.default.fileExists(atPath: imagePath3x) else { return nil }
        return UIImage(named: imageName, in: imageBundle, compatibleWith: nil)
    }
}
extension SVGKImage{
    func eh_tintImage(size: CGSize) -> UIImage{
        self.size = size
        return self.uiImage.withRenderingMode(.alwaysTemplate)
    }
}
public protocol SCImageBaseProtocol{
    /// 遵循者实现返回文件所在文件夹路径  *.bundel  后面的路径  如果没用直接返回空字符串
    func relative() -> String
    /// 遵循者实现返回文件名字
    func fullName() -> String
    /// 遵循者实现返回bundel 路径,例如 Bundle.mian.path(forResource: "EQShareModule", ofType: "bundle")
    func bundlePath() -> String?
}

public protocol AppImageAssetProtocol: SCImageBaseProtocol{
    /// 获取到 SVGKImage
    var svgImage: SVGKImage? { get }
    /// 根据参数获取指定大小颜色的 UIImage
    /// - Parameters:
    ///   - size: 图片大小
    ///   - color: 图片颜色
    /// - Returns: 返回指定要求的 UIImage
    func svgImage(size: Double, color: UIColor) -> UIImage?
    
    /// 根据参数获取指定大小颜色的 UIImage
    /// - Parameters:
    ///   - width: 图片宽度
    ///   - height: 图片高度
    ///   - color: 图片颜色
    /// - Returns: 返回指定要求的 UIImage
    func svgImage(width: Double, height: Double, color: UIColor) -> UIImage?
    /// 获取到 UIImage
    var pngImage: UIImage? { get }
}
extension AppImageAssetProtocol{
    public var svgImage: SVGKImage? {
        guard let bundlePath = bundlePath() else {
            return nil
        }
        return AppResourceManager.shared.svgImage(imageName: fullName(), bundlePath: bundlePath, relative: relative())
    }
    public func svgImage(size: Double, color: UIColor) -> UIImage? {
        return svgImage?.eh_tintImage(size: CGSize(width: size, height: size)).withTintColor(color)
    }
    
    public func svgImage(width: Double, height: Double, color: UIColor) -> UIImage? {
        return svgImage?.eh_tintImage(size: CGSize(width: width, height: height)).withTintColor(color)
    }
    public var pngImage:UIImage?{
        guard let bundlePath = bundlePath() else {
            return nil
        }
        return AppResourceManager.shared.pngImage(imageName: fullName(), bundlePath: bundlePath, relative: relative())
    }
}

enum AppImageAssets: String, AppImageAssetProtocol {
    case ic_com_tabbar_home
    case ic_com_flamingo
    func relative() -> String {
        "TabBar/"
    }
    
    func fullName() -> String {
        self.rawValue
    }
    
    func bundlePath() -> String? {
        Bundle.main.path(forResource: "ImageResource", ofType: "bundle")
    }
}

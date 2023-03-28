//
//  CKPublicColorExtension.swift
//  BLE_Demo01
//
//  Created by anker on 2023/3/5.
//  Copyright © 2023 team. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI
public extension UIColor {
    
    /// 便利构造Hex颜色
    ///
    /// - Parameters:
    ///   - string: hex值
    ///   - alpha: alpha值，默认1.0
    convenience init(hex string: String, alpha: CGFloat = 1.0) {
        
        var hex = string.hasPrefix("#") ? String(string.dropFirst()) : string
        guard hex.count == 3 || hex.count == 6  else {
            self.init(white: 1.0, alpha: 0.0)
            return
        }
        
        if hex.count == 3 {
            for (indec, char) in hex.enumerated() {
                hex.insert(char, at: hex.index(hex.startIndex, offsetBy: indec * 2))
            }
        }
        
        self.init(
            red: CGFloat((Int(hex, radix: 16)! >> 16) & 0xFF) / 255.0,
            green: CGFloat((Int(hex, radix: 16)! >> 8) & 0xFF) / 255.0,
            blue: CGFloat((Int(hex, radix: 16)!) & 0xFF) / 255.0,
            alpha: alpha
        )
    }
    static func customColor(lightModeColor: @escaping () -> UIColor, darkModeColor: @escaping () -> UIColor) -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor { traitCollection in
                if traitCollection.userInterfaceStyle == .dark {
                    return darkModeColor()
                }
                return lightModeColor()
            }
        }
        return lightModeColor()
    }
    static var customTitle: UIColor {
        return UIColor.customColor {
            return UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0) // .black
        } darkModeColor: {
            return UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) // .white
        }
    }
    var toColor: Color{
        return Color(uiColor: self)
    }
}
extension Color{
    /// 主题色
    static var theme: Color{
        return Color(uiColor: UIColor(hex: "6460DC"))
    }
    /// 用Hex创建Color
    static func hex(_ string: String, alpha: CGFloat = 1.0) -> Color{
        return Color(uiColor: UIColor(hex: string, alpha: alpha))
    }
}

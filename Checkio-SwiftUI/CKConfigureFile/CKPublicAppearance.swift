//
//  CKPublicAppearance.swift
//  搭建UI工程
//
//  Created by anker on 2023/1/5.
//  Copyright © 2023 team. All rights reserved.
//

import UIKit
import Photos
import SwiftUI

/// 系统主题色的hex
public let appThemeColorHex = "6460DC"


class CKPublicAppearance: NSObject {
    public static let screenWidth = UIScreen.main.bounds.size.width
    public static let screenHeight = UIScreen.main.bounds.size.height
    /// 安全距离
    public static var safeArea: UIEdgeInsets = {
        if let window = CKPublicAppearance.currentWindow() {
            return window.safeAreaInsets
        }
        return UIEdgeInsets.zero
    }()

    
    /// 获取当前window
    public static func currentWindow() -> UIWindow? {
        if #available(iOS 13.0, *) {
            if
                let window = UIApplication.shared.connectedScenes
                    .filter({ $0.activationState == .foregroundActive })
                    .map({ $0 as? UIWindowScene })
                    .compactMap({ $0 })
                    .first?.windows
                    .filter({ $0.isKeyWindow }).first {
                return window
            } else if let window = UIApplication.shared.delegate?.window {
                return window
            } else {
                return nil
            }
        } else {
            if let window = UIApplication.shared.delegate?.window {
                return window
            } else {
                return nil
            }
        }
    }
    public static func topViewController(_ controller: UIViewController? = CKPublicAppearance.currentWindow()?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            if let visible = navigationController.visibleViewController {
                return topViewController(visible)
            }
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(presented)
        }
        return controller
    }
    
    /// 状态栏高度
    public static var statusBarHeight: CGFloat {
        return isIPhoneX ? 44 : 20
    }
    
    /// 导航栏的高度
    public static var navigationBarHeight: CGFloat {
        return isIPhoneX ? 88 : 64
    }
    
    // MARK: -设备型号
    
    /// iPhoneX系列
    public static let isIPhoneX: Bool = {
        if #available(iOS 11.0, *) {
            if let window = UIApplication.shared.delegate?.window {
                if (window?.safeAreaInsets.bottom ?? 0) > 0 {
                    return true
                }
            }
        }
        return false
    }()
    
    /// iPhoneSE系列
    public static var isIPhoneSE: Bool = {
       return !isIPhoneX && screenWidth < 375.0
    }()
    
    /// iPhone8系列
    public static var isIPhone8: Bool = {
        return !isIPhoneX && screenWidth == 375.0
    }()
    
    /// iPhone8系列
    public static var isIPhone8Plus: Bool = {
        return !isIPhoneX && screenWidth > 375.0
    }()
}
extension UIApplication {
    var keyWindow: UIWindow? {
        connectedScenes
            .compactMap {
                $0 as? UIWindowScene
            }
            .flatMap {
                $0.windows
            }
            .first {
                $0.isKeyWindow
            }
    }
}

private struct SafeAreaInsetsKey: EnvironmentKey {
    static var defaultValue: EdgeInsets {
        UIApplication.shared.keyWindow?.safeAreaInsets.swiftUiInsets ?? EdgeInsets()
    }
}

extension EnvironmentValues {
    var safeAreaInsets: EdgeInsets {
        self[SafeAreaInsetsKey.self]
    }
}

private extension UIEdgeInsets {
    var swiftUiInsets: EdgeInsets {
        EdgeInsets(top: top, leading: left, bottom: bottom, trailing: right)
    }
}

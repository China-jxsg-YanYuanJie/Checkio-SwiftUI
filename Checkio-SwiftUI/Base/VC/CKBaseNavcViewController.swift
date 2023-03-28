//
//  CKBaseNavcViewController.swift
//  BLE_Demo01
//
//  Created by anker on 2023/2/17.
//  Copyright © 2023 team. All rights reserved.
//

import UIKit

class CKBaseNavcViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
// MARK: - NavigationBarStyle

enum NavigationBarStyle {
    /// navbar APP主题
    case theme
    /// navbar 透明
    case clear
    /// navbar 白色的
    case white
}

extension UINavigationController {
    func navBarStyle(_ style: NavigationBarStyle) {
        switch style {
        case .theme:
            navigationBar.barStyle = .black
            let attrDic = [
                NSAttributedString.Key.foregroundColor: UIColor.black,
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18.0)
            ]
            if #available(iOS 13.0, *) {
                let barApp = UINavigationBarAppearance()
                barApp.backgroundColor = .white
                // 基于backgroundColor或backgroundImage的磨砂效果
                barApp.backgroundEffect = nil
                // 阴影颜色（底部分割线），当shadowImage为nil时，直接使用此颜色为阴影色。如果此属性为nil或clearColor（需要显式设置），则不显示阴影。
                // barApp.shadowColor = nil;
                // 标题文字颜色
                barApp.titleTextAttributes = attrDic
                navigationBar.scrollEdgeAppearance = barApp
                navigationBar.standardAppearance = barApp
            } else {
                navigationBar.titleTextAttributes = attrDic

                let navBgImg = UIImage.imageFromColor(
                    UIColor.white,
                    CGSize(width: CKPublicAppearance.screenWidth, height: CKPublicAppearance.navigationBarHeight))

                navigationBar.shadowImage = UIImage()
                navigationBar.setBackgroundImage(navBgImg, for: .default)
            }
            // 透明设置
            navigationBar.isTranslucent = false
            // navigationItem控件的颜色
            navigationBar.tintColor = .black

        case .clear:
            navigationBar.barStyle = .default
            let attrDic = [
                NSAttributedString.Key.foregroundColor: UIColor.black,
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)
            ]

            if #available(iOS 13.0, *) {
                let barApp = UINavigationBarAppearance()
                barApp.backgroundColor = .clear
                // 基于backgroundColor或backgroundImage的磨砂效果
                barApp.backgroundEffect = nil
                // 阴影颜色（底部分割线），当shadowImage为nil时，直接使用此颜色为阴影色。如果此属性为nil或clearColor（需要显式设置），则不显示阴影。
                barApp.shadowColor = nil;
                // 标题文字颜色
                barApp.titleTextAttributes = attrDic
                navigationBar.scrollEdgeAppearance = nil
                navigationBar.standardAppearance = barApp
            } else {
                navigationBar.titleTextAttributes = attrDic
                navigationBar.shadowImage = UIImage()
                let navBgImg = UIImage.imageFromColor(
                    UIColor.clear,
                    CGSize(width: CKPublicAppearance.screenWidth, height: CKPublicAppearance.navigationBarHeight))

                navigationBar.setBackgroundImage(navBgImg, for: .default)
            }
            // 透明设置
            navigationBar.isTranslucent = true
            // navigationItem控件的颜色
            navigationBar.tintColor = .black

        case .white:

            navigationBar.barStyle = .default
            let attrDic = [
                NSAttributedString.Key.foregroundColor: UIColor.black,
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)
            ]

            if #available(iOS 13.0, *) {
                let barApp = UINavigationBarAppearance()
                barApp.backgroundColor = .white
                // 基于backgroundColor或backgroundImage的磨砂效果
                barApp.backgroundEffect = nil
                // 阴影颜色（底部分割线），当shadowImage为nil时，直接使用此颜色为阴影色。如果此属性为nil或clearColor（需要显式设置），则不显示阴影。
                // barApp.shadowColor = nil;
                // 标题文字颜色
                barApp.titleTextAttributes = attrDic
                navigationBar.scrollEdgeAppearance = barApp
                navigationBar.standardAppearance = barApp
            } else {
                navigationBar.titleTextAttributes = attrDic

                let navBgImg = UIImage.imageFromColor(
                    UIColor.white,
                    CGSize(width: CKPublicAppearance.screenWidth, height: CKPublicAppearance.navigationBarHeight))

                navigationBar.shadowImage = UIImage()
                navigationBar.setBackgroundImage(navBgImg, for: .default)
            }
            // 透明设置
            navigationBar.isTranslucent = false
            // navigationItem控件的颜色
            navigationBar.tintColor = .black
        }
    }
}

extension UIImage {
    // 传递颜色，size返回image

    static func imageFromColor(_ color: UIColor,_ viewSize: CGSize) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: viewSize.width, height: viewSize.height)

        UIGraphicsBeginImageContext(rect.size)

        let context: CGContext = UIGraphicsGetCurrentContext()!

        context.setFillColor(color.cgColor)

        context.fill(rect)

        let image = UIGraphicsGetImageFromCurrentImageContext()

        UIGraphicsGetCurrentContext()

        return image!
    }
}

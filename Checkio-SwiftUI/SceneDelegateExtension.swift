//
//  SceneDelegateExtension.swift
//  BLE_Demo01
//
//  Created by anker on 2023/2/17.
//  Copyright © 2023 team. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI
extension SceneDelegate{
    func initWindows() -> UIWindow? {
        self.window?.rootViewController = getAppRootVC()
        self.window?.makeKeyAndVisible()
        return self.window
    }
    func getAppRootVC() -> UIViewController {
        return UIHostingController(rootView: MainTabBarView())
    }
}

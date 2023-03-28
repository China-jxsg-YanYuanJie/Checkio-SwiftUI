//
//  CKBaseViewController.swift
//  BLE_Demo01
//
//  Created by anker on 2023/2/17.
//  Copyright © 2023 team. All rights reserved.
//

import UIKit
//import RxSwift

class CKBaseViewController: UIViewController {
//    let disposeBag = DisposeBag()
    var navcStyle: NavigationBarStyle = .theme
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor(hex: "#F5F5F5")
        _initUI()
        _initLayout()
        _initRxSwift()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navBarStyle(navcStyle)
    }
    
    /// 添加UI都规范到这里
    func _initUI() {}
    /// 添加约束
    func _initLayout() {}
    func _initRxSwift() {}
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

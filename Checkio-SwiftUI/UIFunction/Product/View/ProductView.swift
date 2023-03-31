//
//  ProductView.swift
//  Checkio-SwiftUI
//
//  Created by anker on 2023/3/30.
//  Copyright © 2023 team. All rights reserved.
//

import SwiftUI
import SwiftUIPathAnimations
struct ProductView: View {
    @State var currentPage = 0
    var body: some View {
        NavigationView{
            GeometryReader { proxy in
                VStack{
                    ProductHeaderTabView(currentPage: $currentPage)
                    ProductTabPageView(currentPage: $currentPage)
                }
            }
            .navigationBarItems(trailing: Button(action: {
                print("点击")
            }, label: {
                if let image = AppImageAssets.ic_com_add.svgImage(size: 25, color: .white){
                    Image(uiImage: image)
                }
            }))
            .navigationTitle("所有习惯")
            .navigationBarTitleDisplayMode(.inline)
            .useNXNavigationView(onPrepareConfiguration: {
                $0.navigationBarAppearance.backgroundColor = .clear
                $0.navigationBarAppearance.shadowColor = .clear
                /// item颜色设置
                $0.navigationBarAppearance.tintColor = .white
                /// 标题颜色设置
                $0.navigationBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white, .font:UIFont.boldSystemFont(ofSize: 22)]

            })
            .background(
                ZStack {
                    UIColor(hex: "cccccc").withAlphaComponent(0.2).toColor
                    getHeaderPath().fill(Color.theme)
                }.ignoresSafeArea()
            )
        }
    }
    
    private func getHeaderPath() -> Path{
        let width = CKPublicAppearance.screenWidth
        let height = 200.0
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: width, y: 0))
        path.addLine(to: CGPoint(x: width, y: height))
        path.addQuadCurve(to: CGPoint(x: 0, y: height), control: CGPoint(x: width/2, y: height+50.0))
        return path
    }
}

struct ProductView_Previews: PreviewProvider {
    static var previews: some View {
        ProductView()
    }
}



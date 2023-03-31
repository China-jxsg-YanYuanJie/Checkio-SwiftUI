//
//  MainTabBarView.swift
//  Checkio-SwiftUI
//
//  Created by anker on 2023/3/15.
//  Copyright © 2023 team. All rights reserved.
//

import SwiftUI
import SwiftUIPathAnimations
enum Tab : String ,CaseIterable {
    case home = "Home"
    case product = "Product"
    case position = "Position"
    case found = "Found"
    case my = "My"
    var icon: String{
        switch self {
        case .home:
            return "ic_com_tabbar_home"
        case .product:
            return "ic_com_tabbar_product"
        case .position:
            return "ic_com_tabbar_home"
        case .found:
            return "ic_com_tabbar_home"
        case .my:
            return "ic_com_tabbar_home"
        }
    }
}
struct MainTabBarView: View {
    @State var currentTab: Tab = .product
    // MARK: Hiding Native One
    // 隐藏Native One
    init(){
        UITabBar.appearance().isHidden = true
    }
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $currentTab) {
                // MARK: Need to Apply BG For Each Tab View

                // 需要为每个标签视图应用BG
                HomeView().tag(Tab.home)
                
                ProductView().tag(Tab.product)
                
                Text("Position").tag(Tab.position)
                
                Text("Found").tag(Tab.found)
                
                Text("My").tag(Tab.my)
            }
            PathTabBar(currentTab: $currentTab)
        }
        .ignoresSafeArea()
        .padding(.top, 0)
    }
}

struct MainTabBarView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabBarView()
    }
}


struct PathTabBar: View{
    let icon_width = 35.0
    let icon_sp = 3.0
    @Binding var currentTab: Tab
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    var body: some View {
        GeometryReader { proxy in
            let width = proxy.size.width
            HStack(spacing: 0) {
                ForEach(Tab.allCases, id: \.rawValue) { tab in
                    Button {
                        withAnimation(.easeInOut(duration: 1)) {
                            currentTab = tab
                        }
                    } label: {
                        let xx = currentTab == tab ? icon_sp : 49.0 / 2.0
                        
                        let color: Color = currentTab == tab ? Color.black : Color.gray
                        ZStack {
                            Circle()
                                .foregroundColor(.white)
                                .frame(width: icon_width, height: icon_width)
                            if let image = AppImageAssets(rawValue: tab.icon)?.svgImage(size: 24, color: .white) {
                                Image(uiImage: image)
                                    .foregroundColor(color)
                                    .frame(width: icon_width, height: icon_width, alignment: .center)
                            }
                        }
                        .position(x: width / 5 / 2, y: xx)
                        .animation(.spring(response: 1, dampingFraction: 0.4, blendDuration: 2), value: currentTab)
                    }
                    .frame(width: width / 5, height: 49)
                }
            }
        }
        .frame(height: safeAreaInsets.bottom + 49)
        .background(
            ZStack {
                shape()
            }
        )
    }
    func animation(index: Double) -> Animation {
      return Animation
        .interpolatingSpring(mass: 1, stiffness: 1, damping: 0.5, initialVelocity: 10)
    }
    func shape() -> some View {
        func path(in rect: CGRect) -> Path {
            tabBarPath(rect: rect)
        }
        /// 渐变色
//        LinearGradient(gradient: Gradient(colors: [.pink,.gray,.green,.purple,.black,.blue,.red,.orange]), startPoint:.leading, endPoint:.trailing)
        
        return GeometryReader { proxy in
            let rect = proxy.frame(in: CoordinateSpace.local)
            SimilarShape(path: path(in: rect))
                .fill(.white)
                .shadow(color: Color.black,radius: 10,x: CGFloat(0),y: CGFloat(7))
            //.stroke(Color.red.opacity(0.5)
        }
    }
    func tabBarPath(rect: CGRect) -> Path{
        var path = Path()
        let width = rect.width
        let height = rect.height
        let oneItemWidth = width/5
        let xx1 = icon_width - 14
        let xx2 = icon_sp
        path.move(to: CGPoint(x: 0, y: 0))
        for (index, tab) in Tab.allCases.enumerated() {
            let isCuree = tab == currentTab
            let radius1 = isCuree ? xx1 : 0.0
            let radius2 = isCuree ? xx2 : 0.0
            let py = CGFloat(index) * oneItemWidth
            let control1_1: CGPoint = isCuree ? .init(x: py + oneItemWidth / 2 - radius1 + radius2, y: 0) : .init(x: py + oneItemWidth / 2 - radius1 - radius2, y: 0)
            let control1_2: CGPoint = isCuree ? .init(x: py + oneItemWidth/2 - radius1 - radius2, y: radius1 + radius2) : .init(x: py + oneItemWidth / 2, y: 0)
            
            path.addCurve(to: .init(x: py + oneItemWidth / 2, y: radius1 + radius2), control1: control1_1, control2: control1_2)
            
            let control2_1: CGPoint = isCuree ? .init(x: py + oneItemWidth / 2 + radius1 + radius2, y: radius1 + radius2) : .init(x: py + oneItemWidth / 2, y: 0)
            let control2_2: CGPoint = isCuree ? .init(x: py + oneItemWidth/2 + radius1 - radius2, y: 0) : .init(x: py + oneItemWidth / 2  - radius1 - radius2, y: 0)
            path.addCurve(to: .init(x: py + oneItemWidth, y: 0), control1: control2_1, control2: control2_2)
        }
        path.addLine(to: CGPoint(x: width, y: 0))
        path.addLine(to: CGPoint(x: width, y: height))
        path.addLine(to: CGPoint(x: 0, y: height))
        path.addLine(to: CGPoint(x: 0, y: 0))
        return path
    }
}
extension View{
    func applyBG() -> some View {
        // infinity 无穷的
        self
            .frame(maxWidth:.infinity,maxHeight: .infinity)
            .background{
                UIColor(hex: "cccccc").toColor
                .ignoresSafeArea()
            }
    }
}


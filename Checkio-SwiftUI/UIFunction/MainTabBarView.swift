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
    case my = "My"
    var icon: String{
        switch self {
        case .home:
            return "house"
        case .product:
            return "square.on.square.dashed"
        case .position:
            return "chart.line.uptrend.xyaxis"
        case .my:
            return "person"
        }
    }
}
struct MainTabBarView: View {
    @State var currentTab: Tab = .product
    @State var tabbarHidden: Bool? = false
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

                ProductView(tabbarHidden: $tabbarHidden).tag(Tab.product)

                Text("Position").tag(Tab.position)
                
                Text("My").tag(Tab.my)
            }
            PathTabBar(currentTab: $currentTab)
                .isHidden(tabbarHidden ?? false)
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
    let icon_width = 40.0
    let icon_sp = 3.0
    @Binding var currentTab: Tab
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    var body: some View {
        GeometryReader { proxy in
            let width = proxy.size.width
            let item_width = width/CGFloat(Tab.allCases.count)
            HStack(spacing: 0) {
                ForEach(Tab.allCases, id: \.rawValue) { tab in
                    Button {
                        withAnimation(.easeInOut(duration: 1)) {
                            currentTab = tab
                        }
                    } label: {
                        let xx = currentTab == tab ? 49.0 / 2.0 - 8 : 49.0 / 2.0
                        let color = currentTab == tab ? Color.black : Color.gray
                        let shadow_color = currentTab == tab ? Color.black : Color.clear
                        Image(systemName: tab.icon)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(color)
                            .frame(width: 25)
                            .background(
                                Circle()
                                    .foregroundColor(.white)
                                    .shadow(color: shadow_color.opacity(0.3),radius: 3,x: CGFloat(0),y: CGFloat(0))
                                    .frame(width: icon_width, height: icon_width)
                            )
                            .animation(.spring(response: 1, dampingFraction: 0.3, blendDuration: 1), value: currentTab)
                            .position(x: item_width / 2, y: xx)
                    }
                    .frame(width: item_width, height: 49)
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
                .shadow(color: Color.black.opacity(0.3),radius: 4,x: CGFloat(0),y: CGFloat(0))
        }
    }
    func tabBarPath(rect: CGRect) -> Path{
        var path = Path()
        let width = rect.width
        let height = rect.height
        let oneItemWidth = width/CGFloat(Tab.allCases.count)
        let xx1 = icon_width - icon_sp
        let xx2 = icon_sp
        path.move(to: CGPoint(x: 0, y: 0))
        for (index, tab) in Tab.allCases.enumerated() {
            let isCuree = tab == currentTab
            let radius1 = isCuree ? xx1 : 0.0
            let radius2 = isCuree ? xx2 : 0.0
            let py = CGFloat(index) * oneItemWidth
            let control1_1: CGPoint = isCuree ? .init(x: py + oneItemWidth / 2 - radius1/2 + radius2, y: 0) : .init(x: py + oneItemWidth / 2 - radius1 - radius2, y: 0)
            let control1_2: CGPoint = isCuree ? .init(x: py + oneItemWidth/2 - radius1, y: radius1) : .init(x: py + oneItemWidth / 2, y: 0)
            
            path.addCurve(to: .init(x: py + oneItemWidth / 2, y: radius1 + radius2), control1: control1_1, control2: control1_2)
            
            let control2_1: CGPoint = isCuree ? .init(x: py + oneItemWidth / 2 + radius1, y: radius1) : .init(x: py + oneItemWidth / 2, y: 0)
            let control2_2: CGPoint = isCuree ? .init(x: py + oneItemWidth/2 + radius1/2 - radius2, y: 0) : .init(x: py + oneItemWidth / 2  - radius1 - radius2, y: 0)
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


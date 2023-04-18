//
//  AffairView.swift
//  Checkio-SwiftUI
//
//  Created by anker on 2023/3/26.
//  Copyright © 2023 team. All rights reserved.
//

import SwiftUI
enum TargetCardStyle{
    case day
    case week
    case moth
    var stringValue: String{
        switch self {
        case .day:
            return "天"
        case .week:
            return "周"
        case .moth:
            return "月"
        }
    }
}
struct TargetCardInfo{
    var title: String
    var style: TargetCardStyle
    var tintColor: Color
    var total: Int
    var done: Int
    var imageName: String
    var isAppear = false
}
enum AffairStyle: String, CaseIterable{
    case morning
    case noon
    case afternoon
    case evening
    var infos:[TargetCardInfo]{
        switch self {
        case .morning:
            return getInfos()
        case .noon:
            return getInfos()
        case .afternoon:
            return getInfos()
        case .evening:
            return getInfos()
        }
    }
    var stringValue: String{
        switch self {
        case .morning:
            return "早上"
        case .noon:
            return "中午"
        case .afternoon:
            return "下午"
        case .evening:
            return "晚上"
        }
    }
    private func getInfos() -> [TargetCardInfo] {
        
        return Array(repeating: TargetCardInfo(title: "跑步🏃🏻", style: .day, tintColor: .hex("7A52F2"), total: 1, done: 1, imageName: "ic_com_flamingo"), count: 10)
    }
}
struct AffairView: View {
    var infos:[TargetCardInfo] = [
        TargetCardInfo(title: "跑步🏃🏻", style: .day, tintColor: .hex("7A52F2"), total: 1, done: 1, imageName: "ic_com_flamingo"),
        TargetCardInfo(title: "喝水☕️", style: .day, tintColor: .hex("FA2874"), total: 8, done: 4, imageName: "ic_com_flamingo"),
        TargetCardInfo(title: "恰酒🍺", style: .day, tintColor: .hex("7A52F2"), total: 1, done: 1, imageName: "ic_com_flamingo"),
    ]
    var body: some View {
        LazyVStack{
            ForEach(AffairStyle.allCases,id: \.rawValue){ style in
                if style.infos.count>0 {
                    VStack {
                        HStack {
                            Text(style.stringValue)
                                .font(.system(size: 20, weight: .bold, design: .default))
                                .foregroundColor(.gray)
                                .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
                            Spacer()
                        }
                        ScrollView(.horizontal){
                            LazyHStack(spacing:20){
                                ForEach(style.infos.indices, id: \.self) { index in
                                    AffairItemView(info: style.infos[index], deadline:index)
                                        .animation(.easeInOut(duration: 0.5), value: style.infos[index].isAppear)
                                }
                            }
                            .onChangeParentScrollViewOffset({
                                print($0)
                            })
                        }
                        ._safeAreaInsets(EdgeInsets(top: 0, leading: 25, bottom: 0, trailing: 10))
                        .frame(height:200)
                        .shadow(color: Color.black.opacity(0.3),radius: 10,x: CGFloat(0),y: CGFloat(0))
                    }
                }
            }
        }
        
    }
}
extension View {
    
    func onChangeParentScrollViewOffset(_ perform: @escaping (CGPoint) -> Void) -> some View {
        self
            .background(GeometryReader {
                Color.clear.preference(
                    key: OffsetPreferenceKey.self,
                    value: $0.frame(in: .global).origin
                )
            })
            .onPreferenceChange(
                OffsetPreferenceKey.self,
                perform: perform
            )
    }
}
struct OffsetPreferenceKey: PreferenceKey {
    static var defaultValue = CGPoint.zero // CGPoint に変更
    
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value.x += nextValue().x
        value.y += nextValue().y
        value.x = -value.x // 追加分
        value.y = -value.y // 追加分
    }
}


struct AffairView_Previews: PreviewProvider {
    static var previews: some View {
        AffairView()
    }
}
struct AffairItemView: View {
    @State var info:TargetCardInfo
    var deadline: Int
//    @State var isAppear = false
    var body: some View {
        VStack(alignment: .leading){
            headerCircle(info.tintColor)
            Text(info.title)
                .font(.system(size: 20, weight: .bold, design: .default))
                .padding(EdgeInsets(top: 20, leading: 8, bottom: 0, trailing: 8))
            Spacer()
            HStack(alignment: .center){
                Text("\(info.done)/\(info.total)")
                    .font(.system(size: 20, weight: .bold, design: .default))
                CircleProgress(thickness: 5, progress: CGFloat(info.done)/CGFloat(info.total), isTitleHidden: true)
                    .frame(width: 40, height: 40)
            }.frame(width: 120)
        }
        .frame(width: 120, height: 200, alignment: .topLeading)
        .background(
            RoundedCorners(color: .white, tl: 35, tr: 25, bl: 10, br: 10)
        )
        .offset(x: info.isAppear ? 0 : 120, y: 0)
        .opacity(info.isAppear ? 1 : 0)
        .onAppear {
            info.isAppear = true
        }
    }
    private func headerCircle(_ color: Color = .hex("7A52F2")) -> some View{
        ZStack(alignment: .center){
            let circleWidth = 50.0
            
            Circle()
                .foregroundColor(color.opacity(0.3))
                .frame(width: circleWidth, height: circleWidth, alignment: .top)
                .shadow(color: info.tintColor.opacity(0.8),radius: 5,x: 0.0,y: 5.0)
            if let image = AppImageAssets.ic_com_flamingo.svgImage?.uiImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: circleWidth-10, maxHeight: circleWidth-10)
            }
            
            TitleStyleView(title: info.style.stringValue)
                .frame(width: 20, height: 20)
                .background(
                    RoundedCorners(color: color, tl: 4, tr: 4, bl: 4, br: 4)
                )
                .offset(x: 20, y: 20)
        }
        .offset(x: 8, y: 8)
    }
}
struct StyleCircleView:View{
    var color: Color
    var title: String
    var circleWidth = 50.0
    var titleStyleViewWidth = 20.0
    var body: some View{
        ZStack(alignment: .center){
            
            
            Circle()
                .foregroundColor(color.opacity(0.3))
                .frame(width: circleWidth, height: circleWidth, alignment: .top)
                .shadow(color: color.opacity(0.8),radius: 5,x: 0.0,y: 5.0)
            if let image = AppImageAssets.ic_com_flamingo.svgImage?.uiImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: circleWidth-10, maxHeight: circleWidth-10)
            }
            
            TitleStyleView(title: title)
                .frame(width: titleStyleViewWidth, height: titleStyleViewWidth)
                .background(
                    RoundedCorners(color: color, tl: 4, tr: 4, bl: 4, br: 4)
                )
                .offset(x: (circleWidth-titleStyleViewWidth)/2, y: (circleWidth-titleStyleViewWidth)/2)
        }
    }
}
struct TitleStyleView:View{
    var title: String
    var body: some View{
        Text(title)
            .font(.system(size: 14, weight: .bold, design: .rounded))
            .foregroundColor(.white)
    }
}

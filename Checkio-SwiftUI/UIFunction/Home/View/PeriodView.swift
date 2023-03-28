//
//  PeriodView.swift
//  Checkio-SwiftUI
//
//  Created by anker on 2023/3/26.
//  Copyright © 2023 team. All rights reserved.
//

import SwiftUI

struct PeriodView: View {
    var periodInfos:[PeriodItemInfo] = [
        PeriodItemInfo(title: "以'天'为周期习惯,今天,", total: 5, done: 3),
        PeriodItemInfo(title: "以'周'为周期习惯,本周,", total: 8, done: 6),
        PeriodItemInfo(title: "以'月'为周期习惯,本月", total: 10, done: 7),
    ]
    var body: some View {
        VStack(alignment: .center, spacing: 15) {
            ForEach((0...periodInfos.count-1),id:\.self){ index in
                PeriodItemView(info: periodInfos[index])
                    .frame(height: 80)
            }
        }
    }
}

struct PeriodView_Previews: PreviewProvider {
    static var previews: some View {
        PeriodView()
    }
}
struct PeriodItemInfo {
    var title: String
    var total: Int
    var done: Int
}
struct PeriodItemView: View {
    var info: PeriodItemInfo
    @State var isOnAppear: Bool = false
    var body: some View {
        GeometryReader{ proxy in
            let rect = proxy.frame(in: CoordinateSpace.local)
            ZStack {
                HStack(spacing:10) {
                    VStack(spacing:2){
                        Text(info.title)
                            .foregroundColor(.white.opacity(0.7))
                        HStack(spacing:3) {
                            Text("共需完成")
                                .font(.system(size: 15))
                            Text("\(info.total)")
                                .font(.system(size: 25, weight: .bold, design: .rounded))
                            Text("已完成")
                                .font(.system(size: 15))
                            Text("\(info.done)")
                                .font(.system(size: 25, weight: .bold, design: .rounded))
                        }
                        .foregroundColor(.white)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(
                        RoundedCorners(color: .theme, tl: 30, tr: rect.height/2, bl: 20, br: rect.height/2)
                    )
                    CircleProgress(progress: CGFloat(info.done)/CGFloat(info.total))
                        .frame(width: rect.height, height: rect.height)
                }
                .padding(.leading, 20 )
                .animation(.easeInOut(duration: 1),value: isOnAppear)
                .onAppear {
                    isOnAppear = true
                }
                .offset(x: isOnAppear ? 0 : CKPublicAppearance.screenWidth, y: 0)
                .frame(width: rect.width, height: rect.height)
            }
        }
    }
}

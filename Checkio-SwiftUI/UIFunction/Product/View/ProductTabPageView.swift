//
//  ProductTabPageView.swift
//  Checkio-SwiftUI
//
//  Created by anker on 2023/3/31.
//  Copyright © 2023 team. All rights reserved.
//

import SwiftUI

struct ProductTabPageView: View{
    @Binding var currentPage: Int
    var body: some View{
        TabView(selection: $currentPage){
            ForEach(0 ..< 4) { index in
                ScrollView(.vertical){
                    VStack(spacing:15){
                        ForEach(0 ..< 20){ index in
                            ProductItemView()
                                .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
                                .animation(.easeInOut(duration: 1))
                                .shadow(color: Color.black.opacity(0.1),radius: 6,x: CGFloat(0),y: CGFloat(3))
                        }
                    }
                }
                .tag(index)
                ._safeAreaInsets(EdgeInsets(top: 0, leading: 0, bottom: 49+20, trailing: 0))
            }
        }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
    }
}

struct ProductItemView: View{
    let height = 80.0
    @State var isHiddenB = 0.0
    var body: some View{
        VStack(spacing: 0) {
            HStack(spacing:10){
                StyleCircleView(color: Color.hex("7A52F2"), title: "天", circleWidth: height-20)
                Text("吃蔬菜")
                Spacer()
                Text("记录")
            }
            .frame(height:height)
            .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
            VStack{}
                .frame(width: 100,height:isHiddenB)
        }
        .background(
            RoundedCorners(color: .white, tl: height/2, tr: 10, bl: height/2, br: 10)
        )
        .onTapGesture {
            isHiddenB = isHiddenB == 0.0 ? 100.0 : 0.0
        }
    }
}

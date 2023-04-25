//
//  CKStyleIconSelectedView.swift
//  Checkio-SwiftUI
//
//  Created by anker on 2023/4/20.
//  Copyright © 2023 team. All rights reserved.
//

import SwiftUI


struct CKStyleIconSelectedView: View {
    @Binding var styleInfo: StyleIconInfo
    var appleSymbols = ["house.circle", "person.circle", "bag.circle", "location.circle", "bookmark.circle", "gift.circle", "globe.asia.australia.fill", "lock.circle", "pencil.circle", "link.circle"]
    var styleColors = [appThemeColorHex, "00AAFB", "2C88FF", "AB00B6", "FF2825", "FF2825", "FF4500"]
    let itemSize = 70.0
    @State var styleColorSel = 0
    @State var styleSel = 0
    var rightBlock: () -> Void
    var body: some View {
        VStack(spacing: 0) {
            ScrollView(.horizontal, showsIndicators: false){
                LazyHGrid(rows: [GridItem(.adaptive(minimum: itemSize, maximum: itemSize), spacing: 8)], spacing: 8) {
                    ForEach(0 ... appleSymbols.count - 1, id: \.self) { index in
                        Image(systemName: appleSymbols[index % appleSymbols.count])
                            .font(.system(size: 30))
                            .frame(minWidth: itemSize, minHeight: itemSize, maxHeight: .infinity)
                            .background(styleSel == index ? Color.hex(styleColors[styleColorSel]) : Color(.systemGray6))
                            .cornerRadius(10)
                            .onTapGesture {
                                withAnimation(.easeInOut(duration: 0.5)){
                                    styleSel = index
                                }
                            }
                    }
                }
                .padding(.leading, 15)
                .frame(height: itemSize * 3 + 8 * 2)
            }
            .padding(.top, 30)
            
            ScrollView(.horizontal, showsIndicators: false){
                LazyHGrid(rows: [GridItem(.adaptive(minimum: 45, maximum: 80), spacing: 8)], spacing: 8) {
                    ForEach(0 ... styleColors.count - 1, id: \.self) { index in
                        ZStack {
                            Circle()
                                .fill(.white)
                                .frame(width: 20*2)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                                        .stroke(styleColorSel == index ? Color.hex(styleColors[index]) : .gray.opacity(0.1), lineWidth: styleColorSel == index ? 4 : 2)
                                )
                            Circle()
                                .fill(styleColorSel == index ? .white : Color.hex(styleColors[index]))
                                .padding(10)
                        }.onTapGesture {
                            withAnimation(.easeInOut(duration: 0.5)){
                                styleColorSel = index
                            }
                        }
                    }
                }
                .padding(.leading, 15)
                .frame(height: 45 * 2 + 8)
            }
            .padding(.top, 30)
            
            Button {
                styleInfo.imageName =  appleSymbols[styleSel]
                styleInfo.backColor = styleColors[styleColorSel]
                rightBlock()
            } label: {
                Image("ic_com_right_black")
                    .frame(width: 40, height: 40)
            }
            .padding()

        }
        .onAppear{
            /// 根据传入数据  设置当前选择的颜色和图片
            styleColorSel = styleColors.firstIndex(of: styleInfo.backColor) ?? 0
            styleSel = appleSymbols.firstIndex(of: styleInfo.imageName) ?? 0
        }
        .frame(width: CKPublicAppearance.screenWidth - 40)
        .background {
            Color.white
        }
        .cornerRadius(16)
    }
}

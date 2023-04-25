//
//  AddProduct.swift
//  Checkio-SwiftUI
//
//  Created by anker on 2023/4/14.
//  Copyright © 2023 team. All rights reserved.
//

import SwiftUI
import TextView
struct StyleIconInfo{
    var imageName = "car"
    var backColor = appThemeColorHex
    var name = ""
    var periodOfTime = ""
    var cycle = ""
    var circumference: [String] = []
    var completionTimes = 1
    var textDes = ""
}

struct ProductConfig {
    /// 时段
    var periodOfTime = ["任意", "早上", "上午", "中午", "下午", "晚上"]
    /// 周期
    var cycle = ["天", "周", "月"]
    /// 一周
    var circumference = ["周一", "周二", "周三", "周四", "周五", "周六", "周日"]
}

struct AddProduct: View {
    @Environment(\.presentationMode) private var presentationMode
    @Environment(\.viewController) private var holder
    @State var styleInfo = StyleIconInfo()
    @State var isEdit = false
    let productConfig = ProductConfig()
    var body: some View {
        GeometryReader { proxy in
            ScrollView(.vertical, showsIndicators: false){
                VStack() {
                    iconSelView()
                    textFileView()
                    cycleSelView()
                    numberANDTime()
                    customTextView()
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("保存")
                            .foregroundColor(.white)
                            .frame(width: 150, height: 44)
                            .background(content: {
                                Color.theme
                            })
                            .cornerRadius(22)
                    }
                }
                .frame(width: proxy.size.width)
            }
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                isEdit = false
            }
        }
        .navigationBarBackButtonHidden()
        .navigationBarItems(leading: Button(action: {
            presentationMode.wrappedValue.dismiss()
        }, label: {
            Image("ic_com_arrow_left_white")
        }))
        .navigationTitle("新建习惯")
        .onAppear{
            styleInfo.periodOfTime = productConfig.periodOfTime[0]
            styleInfo.cycle = productConfig.cycle[0]
            styleInfo.circumference = productConfig.circumference
        }
        .background(
            Color.hex("2C4C6B")
                .onTapGesture {
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    isEdit = false
                }
                .ignoresSafeArea()
        )
    }
    /// icon 选择view
    func iconSelView() -> some View{
        HStack(alignment: .bottom) {
            ZStack {
                Circle()
                    .foregroundColor(Color.hex(styleInfo.backColor))
                    .frame(width: 60)
                Image(systemName: styleInfo.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40)
            }
            Button {
                holder?.present(builder: {
                    YYJAlertView { diss in
                        CKStyleIconSelectedView(styleInfo: $styleInfo, rightBlock: {
                            diss()
                        })
                    }
                })
            } label: {
                Image("ic_con_edit_white")
            }

        }
        .padding(.top, 20)
    }
    
    /// 输入框view
    func textFileView() -> some View{
        YYJTextfield(placeholder: "名字...", text: $styleInfo.name,
                     textColor: .white,
                     placeholderColor: Color.hex("98A7B7"),
                     accentColor: .theme,
                     backgroundColor: Color.hex("284263"))
            .padding(EdgeInsets(top: 20, leading: 30, bottom: 0, trailing: 30))
    }
    
    /// 周期选择View
    func cycleSelView() -> some View{
        VStack(alignment: .leading, spacing: 8, content: {
            HStack {
                Text("时段")
                    .foregroundColor(.white)
                    .frame(alignment: .leading)
                Spacer()
            }
            .padding(.leading, 15)
            ScrollView(.horizontal, showsIndicators: false){
                HStack{
                    ForEach(productConfig.periodOfTime,id: \.self){ title in
                        PeriodOfTimeItem(title: title, periodOfTime: $styleInfo.periodOfTime)
                    }
                }
                .padding(.leading, 15)
            }
            VStack(alignment: .leading, spacing: 8, content: {
                HStack {
                    Text("周期")
                        .foregroundColor(.white)
                        .frame(alignment: .leading)
                    Spacer()
                }
                .padding(.leading, 15)
                ScrollView(.horizontal, showsIndicators: false){
                    HStack{
                        ForEach(productConfig.cycle,id: \.self){ title in
                            PeriodOfTimeItem(title: title, periodOfTime: $styleInfo.cycle)
                        }
                    }
                    .padding(.leading, 15)
                }
                ScrollView(.horizontal, showsIndicators: false){
                    HStack{
                        ForEach(productConfig.circumference, id: \.self) { title in
                            CircleItem(title: title, selectedTitle: $styleInfo.circumference)
                        }
                    }
                    .padding(.leading, 15)
                }
            })
            .padding(EdgeInsets(top: 15, leading: 0, bottom: 0, trailing: 0))
        })
        .padding(EdgeInsets(top: 15, leading: 0, bottom: 0, trailing: 0))
    }
    
    /// 时间和次数选择
    func numberANDTime() -> some View{
        VStack{
            HStack{
                Text("每天完成次数")
                    .foregroundColor(.white)
                Spacer()
            }.padding(EdgeInsets(top: 15, leading: 15, bottom: 0, trailing: 0))
            
            HStack(spacing: 0) {
                Button {
                    if styleInfo.completionTimes > 0 {
                        styleInfo.completionTimes -= 1
                    }
                } label: {
                    Image(systemName: "minus")
                        .frame(width: 44,height: 44)
                }
                Text("\(styleInfo.completionTimes)")
                    .frame(width: 44,height: 44)
                    .background {
                        Color.theme
                    }
                    .cornerRadius(8)
                Button {
                    styleInfo.completionTimes += 1
                } label: {
                    Image(systemName: "plus")
                        .frame(width: 44,height: 44)
                }
                Spacer()
            }
            .foregroundColor(.white)
            .padding(EdgeInsets(top: 8, leading: 15, bottom: 0, trailing: 0))
            
            
            HStack{
                Text("提醒时间")
                    .foregroundColor(.white)
                Spacer()
            }.padding(EdgeInsets(top: 15, leading: 15, bottom: 0, trailing: 0))
            
            HStack(spacing: 0) {
                Text("\("16:33")")
                    .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                    .background {
                        Color.theme
                    }
                    .cornerRadius(30)
                Button {
                    styleInfo.completionTimes += 1
                } label: {
                    Image(systemName: "plus")
                        .frame(width: 44,height: 44)
                }
                Spacer()
            }
            .foregroundColor(.white)
            .padding(EdgeInsets(top: 8, leading: 15, bottom: 0, trailing: 0))
        }
    }
    
    func customTextView() -> some View {
        VStack {
            HStack {
                Text("写一句话鼓励自己~")
                Spacer()
            }
            .foregroundColor(.white)
            TextView(
                text: $styleInfo.textDes,
                isEditing: $isEdit,
                placeholder: "Enter text here",
                textColor: .white,
                placeholderColor: Color.hex("98A7B7")
            )
            .frame(height: 60)
            .background {
                Color.hex("284263")
            }
            .cornerRadius(8)
        }
        .onTapGesture {
            isEdit = true
        }
        .padding(.init(top: 0, leading: 15, bottom: 15, trailing: 15))
    }
}

struct PeriodOfTimeItem: View{
    var title: String
    @Binding var periodOfTime: String
    var body: some View{
        Text(title)
            .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
            .foregroundColor(periodOfTime == title ? Color.white : Color.theme)
            .background {
                ZStack {
                    periodOfTime == title ? Color.theme : Color.white
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.theme, lineWidth: 3)
                }
            }
            .cornerRadius(20)
            .onTapGesture {
                
                periodOfTime = title
            }
    }
}

struct CircleItem: View{
    var title: String
    @Binding var selectedTitle: [String]
    var body: some View{
        Text(title)
            .font(.system(size: 13))
            .frame(width: 40, height: 40)
            .foregroundColor(selectedTitle.contains(title) ? Color.white : Color.theme)
            .background {
                ZStack {
                    selectedTitle.contains(title) ? Color.theme : Color.white
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.theme, lineWidth: 3)
                }
            }
            .cornerRadius(20)
            .onTapGesture {
                if let idx = selectedTitle.firstIndex(where: { $0 == title }){
                    selectedTitle.remove(at: idx)
                }else{
                    selectedTitle.append(title)
                }
            }
    }
}


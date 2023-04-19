//
//  YYJTextfield.swift
//  Checkio-SwiftUI
//
//  Created by anker on 2023/4/19.
//  Copyright © 2023 team. All rights reserved.
//

import SwiftUI

struct YYJTextfield: View {
    /// 提示文字
    var placeholder: String = "请输入文字"
    /// 绑定的文字
    @Binding var text: String
    @State var placeholderHidden: Bool = false
    var textColor: Color = .black
    /// 提示文字颜色
    var placeholderColor: Color = UIColor.placeholderText.toColor
    /// 光标颜色
    var accentColor: Color?
    /// 背景颜色
    var backgroundColor: Color = .white
    var body: some View {
        ZStack(alignment: .leading) {
            Text(placeholder)
                .foregroundColor(placeholderColor)
                .isHidden(placeholderHidden)
                .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
            TextField("", text: $text)
                .foregroundColor(textColor)
                .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
                .accentColor(accentColor)
                .onChange(of: text) { newValue in
                    placeholderHidden = newValue.count > 0
                }
        }
        .frame(height: 80)
        .background {
            backgroundColor
        }
        .cornerRadius(16)
        
    }
}

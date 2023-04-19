//
//  AddProduct.swift
//  Checkio-SwiftUI
//
//  Created by anker on 2023/4/14.
//  Copyright © 2023 team. All rights reserved.
//

import SwiftUI

struct AddProduct: View {
    @Environment(\.presentationMode) private var presentationMode
    @State var name = ""
    var body: some View {
        GeometryReader { proxy in
            VStack() {
                HStack(alignment: .bottom) {
                    Image(systemName: "car")
                        .frame(width: 50, height: 50)
                        .background {
                            Circle()
                                .frame(width: 60)
                                .foregroundColor(.red)
                        }
                    Image("ic_con_edit_white")
                }
                .padding(.top, 20)
                
                YYJTextfield(placeholder: "名字...", text: $name,
                             textColor: .white,
                             placeholderColor: Color.hex("98A7B7"),
                             accentColor: .theme,
                             backgroundColor: Color.hex("284263"))
                    .padding(EdgeInsets(top: 20, leading: 30, bottom: 0, trailing: 30))
            }
            .frame(width: proxy.size.width)
        }
        .navigationBarBackButtonHidden()
        .navigationBarItems(leading: Button(action: {
            presentationMode.wrappedValue.dismiss()
        }, label: {
            Image("ic_com_arrow_left_white")
        }))
        .navigationTitle("新建习惯")
        .background(
            Color.hex("2C4C6B")
        )
    }
}

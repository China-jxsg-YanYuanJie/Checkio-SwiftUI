//
//  YYJAlertView.swift
//  Checkio-SwiftUI
//
//  Created by anker on 2023/4/20.
//  Copyright © 2023 team. All rights reserved.
//

import Foundation
import SwiftUI

struct YYJAlertView<Content: View>: View{
    @Environment(\.viewController) private var holder
    @State var appear = false
    /// 动画时间
    var animated = 0.5
    var contentView: (@escaping ()-> Void) -> Content
    var body: some View{
        ZStack{
            Color.black
                .opacity(0.3)
                .onTapGesture {
                    withAnimation(.easeInOut(duration: animated)){
                        appear = false
                        DispatchQueue.main.asyncAfter(deadline: .now() + animated) {
                            holder?.dismiss(animated: false)
                        }
                    }
                }
                .ignoresSafeArea()
            contentView({
                withAnimation(.easeInOut(duration: animated)) {
                    appear = false
                    DispatchQueue.main.asyncAfter(deadline: .now() + animated) {
                        holder?.dismiss(animated: false)
                    }
                }
            })
        }
        .opacity(appear ? 1.0 : 0.0)
        .onAppear{
            withAnimation(.easeInOut(duration: animated)){
                appear = true
            }
        }
    }
}

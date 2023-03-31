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
                    LazyVStack{
                        ForEach(0 ..< 20){ index in
                            Color(.red.withAlphaComponent(0.3))
                                .cornerRadius(10)
                                .padding(.horizontal, 10)
                            Text("page:\(index)")
                        }
                    }
                }
                .tag(index)
                ._safeAreaInsets(EdgeInsets(top: 0, leading: 0, bottom: 49+20, trailing: 0))
            }
        }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
    }
}

//
//  ProductHeaderTabView.swift
//  Checkio-SwiftUI
//
//  Created by anker on 2023/3/31.
//  Copyright © 2023 team. All rights reserved.
//

import SwiftUI
struct ProductHeaderTabView: View{
    @Binding var currentPage: Int
    let size = CGSize(width: 80, height: 30)
    var scrollViewTo: AnyView?
    var body: some View{
        ScrollViewReader{ scrollView in
            ScrollView(.horizontal, showsIndicators: false){
                LazyHStack(spacing:60){
                    ForEach(AffairStyle.allCases.indices, id: \.self){ index in
                        let style = AffairStyle.allCases[index]
                        Text(style.stringValue)
                            .font(.system(size: 20, weight: .bold, design: .default))
                            .foregroundColor(.white)
                            .frame(width: 80)
                            .id(index)
                            .onTapGesture {
                                currentPage = index
                            }
                    }
                }.background(
                    getPath(size: size)
                        .stroke(Color.white, lineWidth: 2)
                        .frame(width: size.width, height: size.height)
                        .position(x: CGFloat(140*currentPage)+size.width/2.0, y: 25)
                        .animation(.easeInOut(duration: 0.5), value: currentPage)
                        
                )
                .padding(EdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 30))
            }
            .frame(height:50)
            .onChange(of: currentPage) { newValue in
                withAnimation(.easeInOut(duration: 1)) {
                    scrollView.scrollTo(currentPage, anchor: .center)
                }
            }
        }
    }
    private func getPath(size: CGSize) -> Path{
        var path = Path()
        path.addRoundedRect(in: CGRect(x: 0, y: 0, width: size.width, height: size.height), cornerSize: CGSize(width: size.height/2, height: size.height/2))
        return path
    }
}

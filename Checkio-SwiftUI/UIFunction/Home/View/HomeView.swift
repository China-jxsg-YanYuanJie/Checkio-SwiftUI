//
//  HomeView.swift
//  Checkio-SwiftUI
//
//  Created by anker on 2023/3/15.
//

import SwiftUI
import NXNavigationExtension

struct HomeView: View {
    var columns: [GridItem] = [GridItem(alignment:.leading)]
    
    var body: some View {
        
        GeometryReader { proxy in
            ScrollView {
                LazyVGrid(columns: columns, spacing: 10) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("下午好,")
                            .font(.system(size: 30, weight: .bold, design: .rounded))
                        Text("且随疾风前行, 身后亦须留心。\nFollow the wind, but watch your back.")
                            .font(.title3)
                    }.padding()
                    PeriodView().padding()
                    AffairView()
                }
             }
        }
        ._safeAreaInsets(EdgeInsets(top: 0, leading: 0, bottom: 49+20, trailing: 0))
        .background(UIColor(hex: "cccccc").withAlphaComponent(0.2).toColor)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

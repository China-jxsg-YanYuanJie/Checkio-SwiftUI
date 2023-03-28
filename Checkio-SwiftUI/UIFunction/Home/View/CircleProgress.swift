//
//  CircleProgress.swift
//  Checkio-SwiftUI
//
//  Created by anker on 2023/3/26.
//  Copyright © 2023 team. All rights reserved.
//

import SwiftUI

struct CircleProgress: View {
    var thickness: CGFloat = 8.0
    var progress: CGFloat = 0.0
    var isTitleHidden: Bool = false
    var tintColor: Color = .theme
    @State var pro:CGFloat = 0.0
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color(.systemGray6),lineWidth: thickness)
            RingShape(progress: pro, thickness: thickness)
                .foregroundColor(tintColor)
            if !isTitleHidden {
                Text("\(Int(progress*100))%")
            }
        }
        .padding(thickness + 2)
        .background(
            Circle()
                .foregroundColor(.white)
        )
        .animation(.easeInOut(duration: 1),value: pro)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
                pro = progress
            }
        }
    }
}

struct CircleProgress_Previews: PreviewProvider {
    static var previews: some View {
        CircleProgress()
    }
}

//内环
struct RingShape: Shape {

    var progress: Double = 0.0
    var thickness: CGFloat = 30.0
    var startAngle: Double = -90.0
    var animatableData: Double {
        get { progress }
        set { progress = newValue }
    }
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addArc(center: CGPoint(x: rect.width / 2.0, y: rect.height / 2.0), radius: min(rect.width, rect.height) / 2.0,startAngle: .degrees(startAngle),endAngle: .degrees(360 * progress+startAngle), clockwise: false)
        
        return path.strokedPath(.init(lineWidth: thickness, lineCap: .round))

    }
}

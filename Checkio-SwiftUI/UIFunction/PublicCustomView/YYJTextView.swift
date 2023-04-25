//
//  YYJTextView.swift
//  Checkio-SwiftUI
//
//  Created by anker on 2023/4/25.
//  Copyright © 2023 team. All rights reserved.
//

import SwiftUI

struct SimpleTextView: UIViewRepresentable {
    typealias Context = UIViewRepresentableContext<SimpleTextView>
    
    @Binding var text: String
    @Binding var height: CGFloat
    
    let width: CGFloat
    var extraHeight: CGFloat = 30
    func makeUIView(context: Context) -> UIView {
        let textView = UITextView()
        textView.delegate = context.coordinator
        textView.font = .preferredFont(forTextStyle: .body)
        textView.isScrollEnabled = false
        textView.backgroundColor = .clear
        
        let uiView = UIView()
        uiView.addSubview(textView)
        
        return uiView
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        let textView = uiView.subviews.first! as! UITextView
        
        if !context.coordinator.isEditing {
            textView.text = text
        }
        
        let bounds = CGSize(width: width, height: height)
        
        DispatchQueue.main.async {
            if extraHeight == 0 {
                height = textView.sizeThatFits(bounds).height
                let size = CGSize(width: width, height: height)
                uiView.frame.size = size
                textView.frame.size = size
            }else{
                height = extraHeight
                let size = CGSize(width: width, height: extraHeight)
                uiView.frame.size = size
                textView.frame.size = size
            }
        }
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(text: $text)
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        var text: Binding<String>
        var isEditing: Bool = false
        
        init(text: Binding<String>) {
            self.text = text
        }
        
        func textViewDidChange(_ textView: UITextView) {
            self.text.wrappedValue = textView.text
        }
        
        func textViewDidBeginEditing(_ textView: UITextView) {
            isEditing = true
        }
        
        func textViewDidEndEditing(_ textView: UITextView) {
            isEditing = false
        }
    }
}

struct YYJTextView: View {
    @State private var height: CGFloat = .zero
    @Binding var text: String
    var extraHeight: CGFloat = 0
    
    init(text: Binding<String>, extraHeight: CGFloat = 0.0) {
        self._text = text
        self.extraHeight = extraHeight
    }
    
    var body: some View {
        GeometryReader { geo in
            SimpleTextView(text: $text, height: $height, width: geo.size.width, extraHeight: extraHeight)
        }
        .frame(height: extraHeight)
    }
}

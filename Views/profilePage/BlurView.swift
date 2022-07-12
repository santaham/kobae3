//
//  BlurView.swift
//  kobae
//
//  Created by sam on 03.07.22.
//

import SwiftUI

struct BlurView: UIViewRepresentable {

    func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .systemChromeMaterialDark))
        
        return view
        
    }

    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
    
    }
}


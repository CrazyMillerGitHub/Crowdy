//
//  LottieView.swift
//  
//
//  Created by Mikhail Borisov on 17.04.2022.
//

import SwiftUI
import Lottie

public struct LottieView: UIViewRepresentable {

    var name: String
    var loopMode: LottieLoopMode = .playOnce
    var animationView = AnimationView()

    public init(name: String, loopMode: LottieLoopMode = .playOnce) {
        self.name = name
        self.loopMode = loopMode
    }

    public func makeUIView(context: UIViewRepresentableContext<LottieView>) -> UIView {
        let view = UIView(frame: .zero)

        animationView.animation = Animation.named(name)
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = loopMode
        animationView.play()

        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)

        NSLayoutConstraint.activate([
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
        
        return view
    }

    public func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<LottieView>) {}
}

//
//  LoadingView.swift
//  AppointmentsBO
//
//  Created by Alin Popa on 22/03/2020.
//  Copyright © 2020 AppStack. All rights reserved.
//

import UIKit
import Lottie

class LoadingView: UIView, XibInstantiableProtocol {
    @IBOutlet private weak var animationView: AnimationView!
    @IBOutlet private var contentView: UIView! {
        get { xibContentView }
        set { xibContentView = newValue }
    }
    
    var xibContentView: UIView!
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        instantiate()
        
        let animation = Animation.named("simple-loader")
        animationView.animation = animation
        animationView.contentMode = .scaleAspectFill
        animationView.loopMode = .loop
    }
    
    func playAnimation() {
        animationView.play()
    }
    
    func stopAnimation() {
        animationView.stop()
    }
}

//
//  LoadingView.swift
//  AppointmentsBO
//
//  Created by Alin Popa on 22/03/2020.
//  Copyright © 2020 AppStack. All rights reserved.
//

import UIKit
import Lottie

public class LoadingView: UIView, XibInstantiableProtocol {
    @IBOutlet private weak var animationView: AnimationView!
    @IBOutlet private var contentView: UIView! {
        get { xibContentView }
        set { xibContentView = newValue }
    }
    
    private let defaultAnimationName: String = "simple-loader"
    
    public var xibContentView: UIView!
    
    public var animation: Animation? {
        get { animationView.animation }
        set { animationView.animation = newValue }
    }
    
    public var animationContentMode: UIView.ContentMode {
        get { animationView.contentMode }
        set { animationView.contentMode = newValue }
    }
    
    public var animationLoopMode: LottieLoopMode {
        get { animationView.loopMode }
        set { animationView.loopMode = newValue }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        instantiate()
        
        animation = Animation.named(defaultAnimationName, bundle: Bundle(for: type(of: self)))
        animationContentMode = .scaleAspectFill
        animationLoopMode = .loop
    }
    
    public func playAnimation() {
        animationView.play()
    }
    
    public func stopAnimation() {
        animationView.stop()
    }
}

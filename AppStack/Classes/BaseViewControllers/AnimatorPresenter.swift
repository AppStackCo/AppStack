//
//  AnimatorPresenter.swift
//  AppointmentsBO
//
//  Created by Alin Popa on 22/03/2020.
//  Copyright © 2020 AppStack. All rights reserved.
//

import UIKit
import Jelly

protocol AnimatorControllerProtocol where Self: UIViewController {
    var animator: Animator? { get set }
}

class AnimatorPresenter {
    private weak var controller: UIViewController!
    private var animator: Animator?
    
    private lazy var defaultSize: CGSize = { presenter in
        CGSize(width: presenter.controller.view.bounds.width * 0.84, height: 400)
    }(self)
    
    init(controller: UIViewController) {
        self.controller = controller
    }
    
    func performCoverPresentation(animatorController: AnimatorControllerProtocol, height: CGFloat, dragInteraction: Bool = false,
                                  isTapBackgroundToDismissEnabled: Bool = true) {
        performCoverPresentation(animatorController: animatorController, size: CGSize(width: defaultSize.width, height: defaultSize.height),
                                 isTapBackgroundToDismissEnabled: isTapBackgroundToDismissEnabled)
    }
    
    func performCoverPresentation(animatorController: AnimatorControllerProtocol, size: CGSize, isTapBackgroundToDismissEnabled: Bool = true) {
        let sideMargin = (UIScreen.main.bounds.width - size.width) / 2
        let marginGuards = UIEdgeInsets(top: 40, left: sideMargin, bottom: 40, right: sideMargin)
        
        let uiConfiguration = PresentationUIConfiguration(cornerRadius: 10, backgroundStyle: .dimmed(alpha: 0.75),
                                                                    isTapBackgroundToDismissEnabled: isTapBackgroundToDismissEnabled)
        let size = PresentationSize(width: .custom(value: size.width), height: .custom(value: .minimum(size.height, 400)))
        let alignment = PresentationAlignment(vertical: .center, horizontal: .center)
        let timing = PresentationTiming(duration: .medium, presentationCurve: .linear, dismissCurve: .linear)
        
        let presentation = CoverPresentation(directionShow: .bottom,
                                             directionDismiss: .bottom,
                                             uiConfiguration: uiConfiguration,
                                             size: size,
                                             alignment: alignment,
                                             marginGuards: marginGuards,
                                             timing: timing)
        
        self.animator = Animator(presentation: presentation)
        animatorController.animator = self.animator
        self.animator?.prepare(presentedViewController: animatorController)
        
        controller.present(animatorController, animated: true)
    }
    
    func performFadeInPresentation(animatorController: AnimatorControllerProtocol, isTapBackgroundToDismissEnabled: Bool = true,
                                   completionHandler: (() -> Void)? = nil) {
        let timing = PresentationTiming(duration: .reallyFast, presentationCurve: .easeInOut, dismissCurve: .easeInOut)
        let presentationConfiguration = PresentationUIConfiguration(cornerRadius: 0.0,
                                                                    backgroundStyle: .blurred(effectStyle: .regular),
                                                                    isTapBackgroundToDismissEnabled: isTapBackgroundToDismissEnabled)
        let presentation = FadePresentation(timing: timing, ui: presentationConfiguration)
        self.animator = Animator(presentation: presentation)
        animatorController.animator = self.animator
        self.animator?.prepare(presentedViewController: animatorController)
        
        controller.present(animatorController, animated: true, completion: completionHandler)
    }
}

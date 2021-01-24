//
//  LoadingIndicator.swift
//  AppointmentsBO
//
//  Created by Alin Popa on 22/03/2020.
//  Copyright © 2020 AppStack. All rights reserved.
//

import Lottie
import RxCocoa
import RxSwift

public class LoadingIndicator {
    private enum LoadingStatus {
        case dismiss
        case present
    }
    
    private let statusSubject = PublishRelay<LoadingStatus>()
    private let loadingView = LoadingView(frame: CGRect.zero)
    
    let disposeBag = DisposeBag()
    
    public static let shared = LoadingIndicator()
    
    private init() {
        statusSubject
            .distinctUntilChanged()
            .buffer(timeSpan: .milliseconds(700), count: 2, scheduler: MainScheduler.instance)
            .filter { $0.count == 1 }
            .map { $0.first ?? .dismiss }
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .do(onNext: { [unowned self] status in
                guard let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else { return }
                
                switch status {
                case .present:
                    guard !window.subviews.contains(self.loadingView) else { return }
                    
                    UIView.transition(with: window, duration: 0.2, options: [.transitionCrossDissolve], animations: {
                        self.loadingView.playAnimation()
                        self.loadingView.fixInView(window)
                    })
                case .dismiss:
                    guard window.subviews.contains(self.loadingView) else { return }
                    
                    UIView.transition(with: window, duration: 0.2, options: [.transitionCrossDissolve], animations: {
                        self.loadingView.stopAnimation()
                        self.loadingView.removeFromSuperview()
                    })
                }
            })
            .subscribe()
            .disposed(by: disposeBag)
    }
    
    /**
     Will set a custom animation given the name of it and the bundle where it is located.
     - Parameter animationName: The name of the lottie animation.
     - Parameter animationBundle: An optional  bundle in which the animation .json file can be located.
     - Parameter contentMode: The content mode of the animation..
     - Parameter loopMode: The loop mode of the animation..
     */
    public func setupAnimation(animationName: String,
                               animationBundle: Bundle? = nil,
                               contentMode: UIView.ContentMode = .scaleAspectFill,
                               loopMode: LottieLoopMode = .loop) {
        loadingView.animation = Animation.named(animationName)
        loadingView.animationContentMode = contentMode
        loadingView.animationLoopMode = loopMode
    }
    
    public func presentLoadingIndicator() {
        statusSubject.accept(.present)
    }
    
    public func dismissLoadingIndicator() {
        statusSubject.accept(.dismiss)
    }
}

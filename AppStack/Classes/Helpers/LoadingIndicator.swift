//
//  LoadingIndicator.swift
//  AppointmentsBO
//
//  Created by Alin Popa on 22/03/2020.
//  Copyright © 2020 AppStack. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

public class LoadingIndicator {
    private enum LoadingStatus {
        case dismiss
        case present
    }
    
    public static let shared = LoadingIndicator()
    private let statusSubject = PublishRelay<LoadingStatus>()
    private let loadingView = LoadingView(frame: CGRect.zero)
    let disposeBag = DisposeBag()
    
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
    
    public func presentLoadingIndicator() {
        statusSubject.accept(.present)
    }
    
    public func dismissLoadingIndicator() {
        statusSubject.accept(.dismiss)
    }
}

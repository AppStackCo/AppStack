//
//  DemoAppCoordinator.swift
//  AppStack-Demo
//
//  Created by Marius Gutoi on 19.07.2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import AppStack
import RxSwift

class DemoAppCoordinator: AppCoordinator {
    
    func start() {
        
        let coordinator = SplashCoordinator()
        coordinator.setup(navigationOption: .newNavigation)
        present(coordinator: coordinator)

        coordinator.coordinatorDidEnd = { [weak self] in
            
            guard let strongSelf = self else { return }
            
            Repository.shared.appStateObservable
                .observe(on: MainScheduler.instance)
                .debug()
                .do { appState in
                    
                    switch appState {
                    
                    case .idle:
                        break
                        
                    case .loggedOut:
                        let loginCoordinator = LoginCoordinator()
                        loginCoordinator.setup(navigationOption: .newNavigation)
                        self?.present(coordinator: loginCoordinator)
                        
                    case .loggedIn:
                        break
                    }
                    
                }
                .subscribe()
                .disposed(by: strongSelf.disposeBag)
        }
        
    }
}

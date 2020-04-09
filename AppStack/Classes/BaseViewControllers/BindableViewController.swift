//
//  BindableViewController.swift
//  AppointmentsBO
//
//  Created by Alin Popa on 09/03/2020.
//  Copyright © 2020 AppStack. All rights reserved.
//

import UIKit

public protocol BindableViewController: class {
    associatedtype VM
    
    var viewModel: VM! { get set }
    var manuallyLoadView: Bool { get }
    
    func bindViewModel()
}

extension BindableViewController where Self: UIViewController {
    public var manuallyLoadView: Bool { true }
    
    public func bindViewModel() {}
    
    public func bindViewModel(viewModel: VM) {
        self.viewModel = viewModel
        
        if manuallyLoadView {
            loadViewIfNeeded()
        }
        
        if isViewLoaded {
            bindViewModel()
        }
    }
}

extension BindableViewController where Self: UIViewController, Self.VM: ScreenFlowViewModel {
    func addLeftBarButtonItem(image: UIImage? = UIImage(named: "chevron.left")) {
        let leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: nil, action: nil)
        
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
        self.navigationItem.hidesBackButton = true
    }
    
    public func addRightBarButtonItem(image: UIImage? = nil) {
        let rightBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: nil, action: nil)
            
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
        self.navigationItem.hidesBackButton = true
    }
    
    public func bindBarButtonActions() {
        navigationItem.leftBarButtonItem?.rx.action = viewModel.leftBarButtonItemAction
        navigationItem.rightBarButtonItem?.rx.action = viewModel.rightBarButtonItemAction
    }
}

extension BindableViewController where Self: UIViewController & DisposableProtocol, Self.VM: LoadingStateViewModel {
    func setupLoading() {
        viewModel.loadingStatusDriver
            .drive(onNext: { status in
                switch status {
                case .loading:
                    LoadingIndicator.shared.presentLoadingIndicator()
                case .idle:
                    LoadingIndicator.shared.dismissLoadingIndicator()
                }
            })
            .disposed(by: disposeBag)
    }
}

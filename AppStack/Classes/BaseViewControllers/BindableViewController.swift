//
//  BindableViewController.swift
//  AppointmentsBO
//
//  Created by Alin Popa on 09/03/2020.
//  Copyright © 2020 AppStack. All rights reserved.
//

import UIKit

public protocol BindableViewController: AnyObject {
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
    func addLeftBarButtonItem(image: UIImage?, systemName: String) {
        let leftBarButtonItem: UIBarButtonItem
        
        if #available(iOS 13, *) {
            leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: systemName), style: .plain, target: nil, action: nil)
        } else {
            leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: nil, action: nil)
        }
        
        navigationItem.leftBarButtonItem = leftBarButtonItem
        navigationItem.hidesBackButton = true
    }
    
    public func addRightBarButtonItem(imageName: String, using systemItem: UIBarButtonItem.SystemItem) {
        let rightBarButtonItem: UIBarButtonItem
        
        if #available(iOS 13, *) {
            rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: imageName), style: .plain, target: nil, action: nil)
        } else {
            rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: systemItem, target: nil, action: nil)
        }
                
        navigationItem.rightBarButtonItem = rightBarButtonItem
        navigationItem.hidesBackButton = true
    }
    
    public func bindBarButtonActions() {
        navigationItem.leftBarButtonItem?.rx.action = viewModel.leftBarButtonItemAction
        navigationItem.rightBarButtonItem?.rx.action = viewModel.rightBarButtonItemAction
    }
}

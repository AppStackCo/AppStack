//
//  ScreenFlowViewController.swift
//  AppointmentsBO
//
//  Created by Alin Popa on 11/03/2020.
//  Copyright © 2020 AppStack. All rights reserved.
//

import UIKit

open class ScreenFlowViewController<VM: ViewModelProtocol & ScreenFlowViewModel>: DisposableViewController,
                                UIGestureRecognizerDelegate, BindableViewController {
    public var viewModel: VM!
    public var manuallyLoadView: Bool { false }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        addLeftBarButtonItem(image: UIImage(named: "back"), systemName: "chevron.left")
        bindViewModel()
        
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    open func bindViewModel() {
        bindBarButtonActions()
        navigationItem.title = viewModel.screenTitle
    }
}

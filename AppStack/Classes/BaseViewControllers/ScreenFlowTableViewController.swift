//
//  ScreenFlowTableViewController.swift
//  AppointmentsBO
//
//  Created by Alin Popa on 11/03/2020.
//  Copyright © 2020 AppStack. All rights reserved.
//

open class ScreenFlowTableViewController<VM: ViewModelProtocol & ScreenFlowViewModel & TableViewViewModelProtocol>: BaseTableViewController<VM> {
    open override func viewDidLoad() {
        addLeftBarButtonItem(image: UIImage(named: "back"), systemName: "chevron.left")
        
        super.viewDidLoad()
    }
    
    open override func bindViewModel() {
        super.bindViewModel()
        bindBarButtonActions()
        navigationItem.title = viewModel.screenTitle
    }
}

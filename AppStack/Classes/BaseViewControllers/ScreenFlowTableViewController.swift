//
//  ScreenFlowTableViewController.swift
//  AppointmentsBO
//
//  Created by Alin Popa on 11/03/2020.
//  Copyright © 2020 AppStack. All rights reserved.
//

open class ScreenFlowTableViewController<VM: ViewModelProtocol & ScreenFlowViewModel & TableViewViewModelProtocol & LoadingStateViewModel>: BaseTableViewController<VM> {
    public override func viewDidLoad() {
        addLeftBarButtonItem()
        
        super.viewDidLoad()
    }
    
    open override func bindViewModel() {
        super.bindViewModel()
        bindBarButtonActions()
    }
}

//
//  ScreenFlowNavigator.swift
//  AppointmentsBO
//
//  Created by Alin Popa on 11/03/2020.
//  Copyright © 2020 AppStack. All rights reserved.
//

import UIKit

public protocol ScreenFlowNavigator {
    func dismiss()
    func dismiss(completionHandler: (() -> Void)?)
    func navigateBack()
}

extension ScreenFlowNavigator where Self: BaseNavigator {
    public func dismiss() {
        self.baseController.dismiss(animated: true)
    }
    
    public func dismiss(completionHandler: (() -> Void)?) {
        self.baseController.dismiss(animated: true, completion: completionHandler)
    }
    
    public func navigateBack() {
        self.baseController.dismiss(animated: true)
    }
}

extension ScreenFlowNavigator where Self: BaseNavigator, Self.VC: UINavigationController {
    func dismiss() {
        self.baseController.dismiss(animated: true)
    }
    
    func dismiss(completionHandler: (() -> Void)?) {
        self.baseController.dismiss(animated: true, completion: completionHandler)
    }
    
    func navigateBack() {
        self.baseController.popViewController(animated: true)
    }
}

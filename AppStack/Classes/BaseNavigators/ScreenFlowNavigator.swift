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
    func navigateToRoot()
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
    
    public func navigateToRoot() {
        self.baseController.dismiss(animated: true)
    }
}

extension ScreenFlowNavigator where Self: BaseNavigator, Self.VC: UINavigationController {
    public func dismiss() {
        self.baseController.dismiss(animated: true)
    }
    
    public func dismiss(completionHandler: (() -> Void)?) {
        self.baseController.dismiss(animated: true, completion: completionHandler)
    }
    
    public func navigateBack() {
        self.baseController.popViewController(animated: true)
    }
    
    public func navigateToRoot() {
        self.baseController.popToRootViewController(animated: true)
    }
}

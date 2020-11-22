//
//  BaseNavigator.swift
//  AppointmentsBO
//
//  Created by Alin Popa on 09/03/2020.
//  Copyright © 2020 AppStack. All rights reserved.
//

import Action
import UIKit

public protocol BaseNavigator: AlertNavigator {
    associatedtype VC: UIViewController
    
    var baseController: VC! { get }
    
    var rootViewController: UIViewController! { get }
    
    init(baseController: VC)
    
    func buildRoot() -> UIViewController
}

extension BaseNavigator where VC: UINavigationController {
    func setRoot() {
        baseController.viewControllers = [buildRoot()]
    }
    
    public func endFlow(_ animated: Bool = true) {
        var viewControllers = baseController.viewControllers
        guard let rootIndex = viewControllers.firstIndex(of: rootViewController) else { fatalError() }
        viewControllers.removeSubrange(rootIndex...)
        baseController.setViewControllers(viewControllers, animated: animated)
    }
}

open class BaseNavigatorImplementation<VC: UIViewController>: BaseNavigator {
    private var animatorPresenter: AnimatorPresenter?
    
    public weak var baseController: VC!
    public weak var rootViewController: UIViewController!
    
    public required init(baseController: VC) {
        self.baseController = baseController
    }
    
    open func buildRoot() -> UIViewController {
        fatalError()
    }
    
    public func presentAlert(using model: AlertControllerModel) {
        let alertViewController: AlertViewController = AlertConnector().buildViewController(navigator: self, storyboard: .common, inputData: model)
        
        animatorPresenter = AnimatorPresenter(controller: baseController)
        animatorPresenter?.performCoverPresentation(animatorController: alertViewController,
                                                    height: alertViewController.getInitialContentHeight(),
                                                    isTapBackgroundToDismissEnabled: true)
    }
    
    public func presentErrorAlert(using error: Error, action: CocoaAction?) {
        let okActionModel = AlertActionModel(title: "OK", style: .default, shouldDismissOnTapAction: true, tapAction: action)
        let alertModel = AlertControllerModel(title: "Error", message: error.localizedDescription,
                                              isTapBackgroundToDismissEnabled: true, style: .alert, actions: [okActionModel])
        
        presentAlert(using: alertModel)
    }
    
    public func presentErrorAlert(using error: Error, completionHandler: (() -> Void)?) {
        let action = CocoaAction {
            completionHandler?()
            return .empty()
        }
        presentErrorAlert(using: error, action: action)
    }
    
    public func dismiss(completionHandler: (() -> Void)?) {
        baseController.dismiss(animated: true, completion: completionHandler)
    }
}

public protocol TabBarViewControllerNavigator {
    func setupRoot()
}

extension TabBarViewControllerNavigator where Self: BaseNavigator, Self.VC: UINavigationController {
    public func setupRoot() {
        setRoot()
    }
}

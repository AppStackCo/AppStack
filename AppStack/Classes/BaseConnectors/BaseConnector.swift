//
//  BaseConnector.swift
//  AppointmentsBO
//
//  Created by Alin Popa on 09/03/2020.
//  Copyright © 2020 AppStack. All rights reserved.
//

import UIKit

public protocol BaseConnector: AnyObject {
    associatedtype ViewModel: ViewModelProtocol
    associatedtype ViewController: BindableViewController & UIViewController
    associatedtype Navigator
    associatedtype InputData = Any
    
    var viewModel: ViewModel? { get set }
    
    func buildViewModel(navigator: Navigator) -> ViewModel
    func buildViewModel(navigator: Navigator, inputData: InputData) -> ViewModel
}

extension BaseConnector {
    public func buildViewController<VC: UIViewController>(navigator: Navigator, storyboard: UIStoryboard? = nil, inputData: InputData? = nil) -> VC {
        var vm: ViewModel
        if let inputData = inputData {
            vm = buildViewModel(navigator: navigator, inputData: inputData)
        } else {
            vm = buildViewModel(navigator: navigator)
        }
        
        var vc: ViewController
        if let storyboard = storyboard {
            vc = ViewController.instantiateFromStoryboard(storyboard: storyboard)
        } else {
            vc = ViewController.init()
        }
        vc.bindViewModel(viewModel: vm as! Self.ViewController.VM)
        
        viewModel = vm
        
        return vc as! VC
    }
    
    public func buildViewModel(navigator: Navigator) -> ViewModel {
        ViewModel.init(navigator: navigator as! ViewModel.N)
    }
    
    public func buildViewModel(navigator: Navigator, inputData: InputData) -> ViewModel {
        // TODO: input data is lost here
        buildViewModel(navigator: navigator)
    }
}

extension BaseConnector where Navigator: BaseNavigator {
    
    public func setupViewControllerWithInitialValue<VC: UIViewController>(viewController: VC, inputData: InputData? = nil) {
        let navigator = Navigator.init(baseController: viewController as! Self.Navigator.VC)
        
        var vm: ViewModel
        if let inputData = inputData {
            vm = buildViewModel(navigator: navigator, inputData: inputData)
        } else {
            vm = buildViewModel(navigator: navigator)
        }
        
        (viewController as! ViewController).bindViewModel(viewModel: vm as! Self.ViewController.VM)
        
        viewModel = vm
    }
}

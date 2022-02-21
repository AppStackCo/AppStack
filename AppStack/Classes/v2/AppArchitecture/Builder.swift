//
//  Builder.swift
//  DemoArchitecture
//
//  Created by Marius Gutoi on 07/02/2019.
//  Copyright © 2019 Marius Gutoi. All rights reserved.
//

import UIKit

public protocol Builder {
    
    /// route
    associatedtype R
    
    /// view model
    associatedtype VM: ViewModel
    
    /// aditional data when intializing view model
    associatedtype D
    
    /// view controller
    associatedtype VC: ViewControllable & UIViewController & StoryboardBased
    
    /// assembly all together
    static func build(route: R, data: D?) -> VC
}

extension Builder {
    public static func build(route: R, data: D? = nil) -> VC {
        let viewModel = VM.init(route: route as! VM.R, data: data as? VM.D)
        var viewController = VC.inflateFromStoryboard()
        viewController.viewModel = viewModel as? VC.VM
        return viewController
    }
}

//
//  UIStoryboard+Extensions.swift
//  AppointmentsBO
//
//  Created by Alin Popa on 09/03/2020.
//  Copyright © 2020 AppStack. All rights reserved.
//

import UIKit

extension UIStoryboard {
    func instantiateViewControllerClass<VC: UIViewController>(viewControllerClass: VC.Type) -> VC {
        let storyboardIdentifier = (viewControllerClass as UIViewController.Type).storyboardIdentifier
        
        return instantiateViewController(withIdentifier: storyboardIdentifier) as! VC
    }
}

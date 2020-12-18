//
//  UIViewController+Extension.swift
//  DigiCatch
//
//  Created by Marius Gutoi on 06/11/2020.
//  Copyright © 2020 AppStack. All rights reserved.
//

import UIKit

extension UIViewController {
    
    public func add(_ child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }

    public func insert(_ child: UIViewController, belowSubview: UIView) {
        addChild(child)
        view.insertSubview(child.view, belowSubview: belowSubview)
        child.didMove(toParent: self)
    }
    
    public func remove() {
        // Just to be safe, we check that this view controller
        // is actually added to a parent before removing it.
        guard parent != nil else {
            return
        }

        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}

//
//  StoryboardBased.swift
//  InvestifyApp
//
//  Created by Marius Gutoi on 24/05/2018.
//  Copyright © 2018 Fooder. All rights reserved.
//

import UIKit

public protocol StoryboardBased: class {
    
    static var storyboardIdentifier: String { get }
    static var owningStoryboard: UIStoryboard { get }
}

extension StoryboardBased where Self: UIViewController {
    
    public static var storyboardIdentifier: String {
        return String(describing: self)
    }
    
    public static func inflateFromStoryboard() -> Self {
        return owningStoryboard.instantiate()
    }
}

extension UIStoryboard {
    
    func instantiateInitial<T: UIViewController>() -> T {
        guard let viewController = instantiateInitialViewController() as? T else {
            fatalError("No initial view controller in storyboard")
        }
        return viewController
    }
    
    func instantiate<T: StoryboardBased>() -> T {
        guard let viewController = instantiateViewController(withIdentifier: T.storyboardIdentifier) as? T else {
            fatalError("No view controller in storyboard")
        }
        return viewController
    }
}

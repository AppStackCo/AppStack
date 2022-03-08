//
//  SplashViewController.swift
//  AppStack
//
//  Created by Marius Gutoi on 19.07.2021.
//  Copyright (c) 2021 AppStack. All rights reserved.
//

import AppStack
import RxCocoa
import RxSwift
import UIKit

final class SplashViewController: UIViewController, ViewControllable {
    
    var viewModel: SplashViewModel!
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

extension SplashViewController: StoryboardBased {
    static var owningStoryboard: UIStoryboard {
        return .main
    }
}

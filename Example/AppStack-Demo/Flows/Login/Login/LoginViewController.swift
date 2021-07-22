//
//  LoginViewController.swift
//  AppStack
//
//  Created by Marius Gutoi on 22.07.2021.
//  Copyright (c) 2021 CocoaPods. All rights reserved.
//

import AppStack
import RxCocoa
import RxSwift
import UIKit

final class LoginViewController: UIViewController, ViewControllable {
    
    var viewModel: LoginViewModel!
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Login"
    }
}

extension LoginViewController: StoryboardBased {
    static var owningStoryboard: UIStoryboard {
        return .login
    }
}

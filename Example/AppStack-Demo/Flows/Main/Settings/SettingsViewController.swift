//
//  SettingsViewController.swift
//  AppStack
//
//  Created by Marius Gutoi on 22.07.2021.
//  Copyright (c) 2021 CocoaPods. All rights reserved.
//

import AppStack
import RxCocoa
import RxSwift
import UIKit

final class SettingsViewController: UIViewController, ViewControllable {
    
    var viewModel: SettingsViewModel!
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

extension SettingsViewController: StoryboardBased {
    static var owningStoryboard: UIStoryboard {
        return .main
    }
}

//
//  ViewControllable.swift
//  DemoArchitecture
//
//  Created by Marius Gutoi on 07/02/2019.
//  Copyright © 2019 Marius Gutoi. All rights reserved.
//

import Foundation

public protocol ViewControllable {
    associatedtype VM: ViewModel
    var viewModel: VM! { get set }    
}

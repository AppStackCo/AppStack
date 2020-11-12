//
//  ViewModel.swift
//  DemoArchitecture
//
//  Created by Marius Gutoi on 07/02/2019.
//  Copyright © 2019 Marius Gutoi. All rights reserved.
//

import Foundation

public protocol ViewModel {
    associatedtype R
    associatedtype D
    var route: R { get }
    var data: D? { get }
    init(route: R, data: D?)
}

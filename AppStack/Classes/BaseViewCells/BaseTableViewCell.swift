//
//  BaseTableViewCell.swift
//  AppointmentsBO
//
//  Created by Alin Popa on 09/03/2020.
//  Copyright © 2020 AppStack. All rights reserved.
//

import UIKit

public protocol BaseTableViewCell {
    func update(using viewModel: BaseTableViewCellViewModel)
    static var identifier: String { get }
}

extension BaseTableViewCell where Self: UITableViewCell {
    public static var identifier: String { String(describing: self) }
}

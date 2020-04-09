//
//  SelectableTableViewCellViewModel.swift
//  AppointmentsBO
//
//  Created by Alin Popa on 09/03/2020.
//  Copyright © 2020 AppStack. All rights reserved.
//

import Action

public protocol SelectableTableViewCellViewModel: BaseTableViewCellViewModel {
    var selectedAction: CocoaAction { get }
}

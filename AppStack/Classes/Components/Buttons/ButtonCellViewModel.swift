//
//  ButtonCellViewModel.swift
//  AppointmentsBO
//
//  Created by Alin Popa on 23/03/2020.
//  Copyright © 2020 AppStack. All rights reserved.
//

import Action

struct ButtonCellViewModel: ButtonTableViewCellInputData, BaseTableViewCellViewModel {
    var title: String
    var action: CocoaAction
    let identifier = ButtonTableViewCell.identifier
}

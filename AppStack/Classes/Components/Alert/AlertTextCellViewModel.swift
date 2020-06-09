//
//  AlertTextCellViewModel.swift
//  AppointmentsBO
//
//  Created by Alin Popa on 22/03/2020.
//  Copyright © 2020 AppStack. All rights reserved.
//

struct AlertTextCellViewModel: AlertTextTableViewCellInputData, BaseTableViewCellViewModel {
    var text: String
    let identifier = AlertTextTableViewCell.identifier
}

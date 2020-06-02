//
//  AlertMessageCellViewModel.swift
//  AppointmentsBO
//
//  Created by Alin Popa on 22/03/2020.
//  Copyright © 2020 AppStack. All rights reserved.
//

struct AlertMessageCellViewModel: AlertTextTableViewCellInputData, BaseTableViewCellViewModel {
    var text: String
    let identifier = AlertMessageTableViewCell.identifier
}

//
//  AlertMessageTableViewCell.swift
//  AppointmentsBO
//
//  Created by Alin Popa on 22/03/2020.
//  Copyright © 2020 AppStack. All rights reserved.
//

import UIKit

protocol AlertMessageTableViewCellInputData {
    var text: String { get }
}

class AlertMessageTableViewCell: UITableViewCell, BaseTableViewCell {
    @IBOutlet private weak var label: BaseLabel! {
        didSet {
            label.textStyle = .asAlertMessage
        }
    }
    
    func update(using viewModel: BaseTableViewCellViewModel) {
        guard let model = viewModel as? AlertTextTableViewCellInputData else { return }
        label.setText(model.text)
    }
}

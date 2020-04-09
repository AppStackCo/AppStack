//
//  AlertTextTableViewCell.swift
//  AppointmentsBO
//
//  Created by Alin Popa on 22/03/2020.
//  Copyright © 2020 AppStack. All rights reserved.
//

import UIKit

protocol AlertTextTableViewCellInputData {
    var text: String { get }
    var textStyle: TextStyle { get }
}

class AlertTextTableViewCell: UITableViewCell, BaseTableViewCell {
    @IBOutlet private weak var label: UILabel!
    
    func update(using viewModel: BaseTableViewCellViewModel) {
        guard let model = viewModel as? AlertTextTableViewCellInputData else { return }
        
        label.attributedText = model.textStyle.attributedText(for: model.text)
    }
}

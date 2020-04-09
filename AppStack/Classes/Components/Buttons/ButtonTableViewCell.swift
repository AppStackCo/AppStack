//
//  ButtonTableViewCell.swift
//  AppointmentsBO
//
//  Created by Alin Popa on 23/03/2020.
//  Copyright © 2020 AppStack. All rights reserved.
//

import Action
import UIKit

protocol ButtonTableViewCellInputData {
    var title: String { get }
    var action: CocoaAction { get }
}

class ButtonTableViewCell: UITableViewCell, BaseTableViewCell {
    @IBOutlet private weak var button: UIButton!
    
    func update(using viewModel: BaseTableViewCellViewModel) {
        guard let model = viewModel as? ButtonTableViewCellInputData else { return }
        
        button.setTitle(model.title, for: .normal)
        button.rx.action = model.action
    }
}

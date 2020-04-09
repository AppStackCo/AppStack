//
//  DisposableTableViewCell.swift
//  AppointmentsBO
//
//  Created by Alin Popa on 26/03/2020.
//  Copyright © 2020 AppStack. All rights reserved.
//

import RxSwift
import UIKit

open class DisposableTableViewCell: UITableViewCell {
    public var disposeBag = DisposeBag()
    
    open override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
}

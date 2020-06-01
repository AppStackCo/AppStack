//
//  Size.swift
//  AppointmentsBO
//
//  Created by Alin Popa on 25/03/2020.
//  Copyright © 2020 AppStack. All rights reserved.
//

import UIKit

enum Size {
    case estimatedTableRowHeight
    
    var value: CGFloat {
        switch self {
        case .estimatedTableRowHeight:
            return 50
        }
    }
}

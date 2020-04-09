//
//  TextFieldDescription.swift
//  AppointmentsBO
//
//  Created by Alin Popa on 24/03/2020.
//  Copyright © 2020 AppStack. All rights reserved.
//

import UIKit

struct TextFieldDescription {
    let inputTextStyle: TextStyle
    let placeholderTextStyle: TextStyle
    let textAlignment: NSTextAlignment
    let tintColor: UIColor
}

extension TextFieldDescription {
    static func buildDefault() -> TextFieldDescription {
        TextFieldDescription(inputTextStyle: .textFieldInput,
                             placeholderTextStyle: .textFieldPlaceholder,
                             textAlignment: .left,
                             tintColor: .black)
    }
}

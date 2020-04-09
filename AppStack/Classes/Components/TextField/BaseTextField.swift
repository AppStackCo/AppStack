//
//  BaseTextField.swift
//  AppointmentsBO
//
//  Created by Alin Popa on 24/03/2020.
//  Copyright © 2020 AppStack. All rights reserved.
//

import RxCocoa
import RxSwift
import SkyFloatingLabelTextField

enum BaseTextFieldType {
    case `default`
    
    var description: TextFieldDescription {
        switch self {
        case .default:
            return TextFieldDescription.buildDefault()
        }
    }
}

public class BaseTextField: SkyFloatingLabelTextField {
    public override var placeholder: String? {
        didSet {
            setupPlaceholderTitle(placeholder: placeholder)
        }
    }
    
    // Used to apply custom formatters in the future
    var formattedText: ControlProperty<String?> {
        rx.controlProperty(editingEvents: .allEditingEvents,
            getter: { textField in
                textField.text
            }, setter: { textField, value in
                if textField.text != value {
                    textField.text = value
                }
            })
    }
    
    var type: BaseTextFieldType {
        currentType ?? .default
    }
    
    private var currentType: BaseTextFieldType?
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        setupStyle(with: type)
    }
    
    func setupStyle(with type: BaseTextFieldType) {
        currentType = type
        
        let description = type.description
        tintColor = description.tintColor
        defaultTextAttributes = NSAttributedStringBuilder()
            .with(font: description.inputTextStyle.font)
            .with(foregroundColor: description.inputTextStyle.color)
            .with(kern: description.inputTextStyle.kern)
            .getAttributes()
        textAlignment = description.textAlignment
        titleFont = description.placeholderTextStyle.font
        selectedTitleColor = description.placeholderTextStyle.color
    }
    
    public func styledPlaceholderTitle() -> Binder<String?> {
        Binder(self) { textField, placeholder -> Void in
            textField.setupPlaceholderTitle(placeholder: placeholder)
        }
    }
    
    private func setupPlaceholderTitle(placeholder: String?) {
        let description = type.description
        let placeholderText = description.placeholderTextStyle.uppercased ? placeholder?.uppercased() : placeholder
        attributedPlaceholder = NSAttributedStringBuilder(baseString: placeholderText ?? "")
            .with(font: description.placeholderTextStyle.font)
            .with(foregroundColor: description.placeholderTextStyle.color)
            .with(kern: description.placeholderTextStyle.kern)
            .build()
        titleLabel.attributedText = attributedPlaceholder
    }
}

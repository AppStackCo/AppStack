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

public class BaseTextField: SkyFloatingLabelTextField {
    
    var textStyle: TextStyle! {
        didSet {
            defaultTextAttributes = textStyle.stringAttributes
        }
    }
    var placeholderTextStyle: TextStyle! {
        didSet {
            titleFont = placeholderTextStyle.font
            selectedTitleColor = placeholderTextStyle.color
        }
    }
    
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
    
    public override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func styledPlaceholderTitle() -> Binder<String?> {
        Binder(self) { textField, placeholder -> Void in
            textField.setupPlaceholderTitle(placeholder: placeholder)
        }
    }
    
    private func setupPlaceholderTitle(placeholder: String?) {
        
        guard let placeholderTextStyle = placeholderTextStyle else {
            fatalError("there is no text field style assigned to this text field")
        }
        
        let placeholderText = placeholder?.uppercased()
       
        attributedPlaceholder = NSAttributedStringBuilder(baseString: placeholderText ?? "")
            .with(font: placeholderTextStyle.font)
            .with(foregroundColor: placeholderTextStyle.color)
            .with(kern: placeholderTextStyle.kern)
            .build()
        
        titleLabel.attributedText = attributedPlaceholder
    }
}

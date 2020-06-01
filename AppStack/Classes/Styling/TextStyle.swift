//
//  TextStyle.swift
//  AppointmentsBO
//
//  Created by Alin Popa on 24/03/2020.
//  Copyright © 2020 AppStack. All rights reserved.
//

import UIKit

public enum TextStyle {
    case alertTitle
    case alertMessage
    case textFieldInput
    case textFieldPlaceholder
    case label
    
    var font: UIFont {
        switch self {
        case .alertTitle:
            return .systemFont(ofSize: 20)
        case .alertMessage, .textFieldInput, .label:
            return .systemFont(ofSize: 16)
        case .textFieldPlaceholder:
            return .systemFont(ofSize: 12)
        }
    }
    
    var color: UIColor {
        switch self {
        case .textFieldInput, .alertTitle, .alertMessage, .label:
            return .black
        case .textFieldPlaceholder:
            return .darkGray
        }
    }
    
    var uppercased: Bool {
        switch self {
        case .textFieldInput, .textFieldPlaceholder:
            return true
        default:
            return false
        }
    }
    
    var kern: CGFloat? {
        switch self {
        case .textFieldInput, .textFieldPlaceholder:
            return 1.5
        default:
            return nil
        }
    }
    
    public func attributedText(for text: String?) -> NSAttributedString? {
        NSAttributedStringBuilder(baseString: text)
            .with(font: font)
            .with(foregroundColor: color)
            .with(kern: kern)
            .build()
    }
    
    public var stringAttributes: [NSAttributedString.Key: Any] {
        var attrs: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: color]
        
        if let kern = kern {
            attrs[.kern] = kern
        }
        
        return attrs
    }
}

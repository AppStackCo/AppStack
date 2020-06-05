//
//  Style+AppStack.swift
//  abseil
//
//  Created by Marius Gutoi on 02/06/2020.
//

extension UIColor {
    static let as_primary = UIColor(hex: "#3598EE")
    static let as_secondary = UIColor(hex: "#808080")
    static let as_text_dark = UIColor(hex: "#202020")
    static let as_text_light = UIColor(hex: "#808080")
}

extension UIFont {
    static let as_heading1 = UIFont.systemFont(ofSize: 20)
    static let as_heading2 = UIFont.systemFont(ofSize: 16)
    static let as_body = UIFont.systemFont(ofSize: 12)
}

extension TextStyle {
    static let alertTitle = TextStyle(font: .as_heading1, color: .as_text_dark)
    static let alertMessage = TextStyle(font: .as_heading2, color: .as_text_dark)

    static let textFieldInput = TextStyle(font: .as_heading2, color: .as_text_dark, kern: 1.5)
    static let textFieldPlaceholder = TextStyle(font: .as_body, color: .as_text_light, kern: 1.5)
}

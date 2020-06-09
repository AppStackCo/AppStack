//
//  Style+AppStack.swift
//  AppStack
//
//  Created by Marius Gutoi on 02/06/2020.
//  Copyright © 2020 AppStack. All rights reserved.
//

extension UIColor {
    static let asPrimary = UIColor(hex: "#3598EE")
    static let asSecondary = UIColor(hex: "#808080")
    static let asTextDark = UIColor(hex: "#202020")
    static let asTextLight = UIColor(hex: "#808080")
}

extension UIFont {
    static let asHeading1 = UIFont.systemFont(ofSize: 20)
    static let asHeading2 = UIFont.systemFont(ofSize: 18, weight: .medium)
    static let asHeading3 = UIFont.systemFont(ofSize: 16)
    static let asBody = UIFont.systemFont(ofSize: 12)
}

extension TextStyle {
    static let asAlertTitle = TextStyle(font: .asHeading1, color: .asTextDark)
    static let asAlertMessage = TextStyle(font: .asHeading3, color: .asTextDark)

    static let asTextFieldInput = TextStyle(font: .asHeading3, color: .asTextDark, kern: 1.5)
    static let asTextFieldPlaceholder = TextStyle(font: .asBody, color: .asTextLight, kern: 1.5)
}

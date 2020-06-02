//
//  Style+AppStack.swift
//  abseil
//
//  Created by Marius Gutoi on 02/06/2020.
//

extension TextStyle {
    static var alertTitle = TextStyle(font: .systemFont(ofSize: 20), color: .black)
    static var alertMessage = TextStyle(font: .systemFont(ofSize: 16), color: .black)

    static var textFieldInput = TextStyle(font: .systemFont(ofSize: 16), color: .black, kern: 1.5, lineSpacing: nil)
    static var textFieldPlaceholder = TextStyle(font: .systemFont(ofSize: 12), color: .darkGray, kern: 1.5, lineSpacing: nil)
}

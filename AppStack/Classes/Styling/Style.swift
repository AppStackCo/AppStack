//
//  Style.swift
//  AppointmentsBO
//
//  Created by Marius Gutoi on 29/05/2020.
//  Copyright © 2020 AppStack. All rights reserved.
//

import Overture
import UIKit

extension CGFloat {
  public static func as_grid(_ value: Int) -> CGFloat {
    return CGFloat(value) * 4.0
  }
}

// views

//let roundedStyle: (UIView) -> Void = {
//    $0.clipsToBounds = true
//    $0.layer.cornerRadius = 6
//}

let roundedStyle: (UIView) -> Void = concat(
    mut(\.clipsToBounds, true),
    mut(\.layer.cornerRadius, 6)
)

func borderedStyle(_ color: UIColor) -> (UIView) -> Void {
    return { view in
        view.layer.borderColor = color.cgColor
        view.layer.borderWidth = 2
    }
}

// buttons

let baseButtonStyle: (UIButton) -> Void = {
    $0.contentEdgeInsets = UIEdgeInsets(top: .as_grid(3), left: .as_grid(4), bottom: .as_grid(3), right: .as_grid(4))
    $0.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
}

let roundedButtonStyle = concat(
    baseButtonStyle,
    roundedStyle
)

public let borderedButtonStyle =
    concat(
        baseButtonStyle,
        roundedStyle,
        borderedStyle(.black)) {
            $0.tintColor = .black
        }


public let filledButtonStyle = concat(roundedButtonStyle) {
    $0.backgroundColor = .black
    $0.tintColor = .white
}

public let simpleButtonStyle = concat(baseButtonStyle) {
    $0.tintColor = .darkGray
}

// labels

// text fields

public let defaultTextFieldStyle: (BaseTextField) -> Void  = {
    
    $0.textStyle = .textFieldInput
    $0.placeholderTextStyle = .textFieldPlaceholder
    
    $0.tintColor = .black
    $0.textAlignment = .left
}

// text views

// navigation bars

// tabbar

// fonts

public struct TextStyle2 {
    let font: UIFont
    let color: UIColor
    let kern: CGFloat?
    let lineSpacing: CGFloat?
    
    public init(font: UIFont, color: UIColor, kern: CGFloat?, lineSpacing: CGFloat?) {
        self.font = font
        self.color = color
        self.kern = kern
        self.lineSpacing = lineSpacing
    }
    
    public func attributedText(for text: String, newColor: UIColor? = nil) -> NSAttributedString? {
    
        var usedColor = color
        if let newColor = newColor {
            usedColor = newColor
        }
        
        return  NSAttributedStringBuilder(baseString: text)
            .with(font: font)
            .with(foregroundColor: usedColor)
            .with(kern: kern)
            .with(lineSpacing: lineSpacing)
            .build()
    }
}

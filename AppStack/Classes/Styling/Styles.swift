//
//  Styles.swift
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

/// Views

//func roundedStyle(radius: CGFloat) -> (UIView) -> Void {
//    return {
//        $0.clipsToBounds = true
//        $0.layer.cornerRadius = radius
//    }
//}

func roundedStyle(radius: CGFloat) -> (UIView) -> Void {
    return concat(
        mut(\.clipsToBounds, true),
        mut(\.layer.cornerRadius, radius)
    )
}

func borderedStyle(color: UIColor, width: CGFloat) -> (UIView) -> Void {
    return { view in
        view.layer.borderColor = color.cgColor
        view.layer.borderWidth = width
    }
}

let as_roundedStyle: (UIView) -> Void = roundedStyle(radius: 6)
let as_borderedStyle: (UIView) -> Void = borderedStyle(color: .as_primary, width: 2.0)

/// Buttons

let as_baseButtonStyle: (UIButton) -> Void = {
    $0.contentEdgeInsets = UIEdgeInsets(
        top: .as_grid(3),
        left: .as_grid(4),
        bottom: .as_grid(3),
        right: .as_grid(4))
    $0.titleLabel?.font = .as_heading2
}

let as_roundedButtonStyle = concat(
    as_baseButtonStyle,
    as_roundedStyle
)

public let as_borderedButtonStyle =
    concat(
        as_baseButtonStyle,
        as_roundedStyle,
        as_borderedStyle) {
            $0.tintColor = .black
        }

public let as_filledButtonStyle =
    concat(as_roundedButtonStyle) {
        $0.backgroundColor = .black
        $0.tintColor = .white
}

public let as_simpleButtonStyle =
    concat(as_baseButtonStyle) {
        $0.tintColor = .darkGray
}

/// Labels

/// Text fields

public let as_defaultTextFieldStyle: (BaseTextField) -> Void  = {
    
    $0.textStyle = .as_textFieldInput
    $0.placeholderTextStyle = .as_textFieldPlaceholder
    
    $0.tintColor = .black
    $0.textAlignment = .left
}

/// Text views

/// Navigation bars

/// Tabbar

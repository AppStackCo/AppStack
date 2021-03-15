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
  public static func asGrid(_ value: Int) -> CGFloat {
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

let asRoundedStyle: (UIView) -> Void = roundedStyle(radius: 6)
let asBorderedStyle: (UIView) -> Void = borderedStyle(color: .asPrimary, width: 2.0)

/// Buttons

let asBaseButtonStyle: (UIButton) -> Void = {
    $0.contentEdgeInsets = UIEdgeInsets(
        top: .asGrid(3),
        left: .asGrid(4),
        bottom: .asGrid(3),
        right: .asGrid(4))
    $0.titleLabel?.font = .asHeading2
}

let asRoundedButtonStyle = concat(
    asBaseButtonStyle,
    asRoundedStyle
)

public let asBorderedButtonStyle =
    concat(
        asBaseButtonStyle,
        asRoundedStyle,
        asBorderedStyle, and:  {
            $0.tintColor = .black
        })

public let asFilledButtonStyle =
    concat(asRoundedButtonStyle, and:  {
        $0.backgroundColor = .black
        $0.tintColor = .white
    })

public let asSimpleButtonStyle =
    concat(asBaseButtonStyle, and:  {
        $0.tintColor = .darkGray
    })

/// Labels

/// Text fields

public let asDefaultTextFieldStyle: (BaseTextField) -> Void  = {
    
    $0.textStyle = .asTextFieldInput
    $0.placeholderTextStyle = .asTextFieldPlaceholder
    
    $0.tintColor = .black
    $0.textAlignment = .left
}

/// Text views

/// Navigation bars

/// Tabbar

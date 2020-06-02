//
//  TextStyle.swift
//  AppointmentsBO
//
//  Created by Alin Popa on 24/03/2020.
//  Copyright © 2020 AppStack. All rights reserved.
//

import UIKit

public struct TextStyle {
    let font: UIFont
    let color: UIColor
    let kern: CGFloat?
    let lineSpacing: CGFloat?
    
    public init(font: UIFont, color: UIColor, kern: CGFloat? = nil, lineSpacing: CGFloat? = nil) {
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

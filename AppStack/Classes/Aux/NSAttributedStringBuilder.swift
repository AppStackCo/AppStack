//
//  NSAttributedStringBuilder.swift
//  AppointmentsBO
//
//  Created by Alin Popa on 24/03/2020.
//  Copyright © 2020 AppStack. All rights reserved.
//

import Foundation
import UIKit

class NSAttributedStringBuilder {
    private var baseString: String?
    private var attributes: [NSAttributedString.Key: Any] = [:]
    
    init(baseString: String? = nil) {
        self.baseString = baseString
    }
    
    func with(font: UIFont) -> NSAttributedStringBuilder {
        attributes[.font] = font
        return self
    }
    
    func with(foregroundColor: UIColor) -> NSAttributedStringBuilder {
        attributes[.foregroundColor] = foregroundColor
        return self
    }
    
    func with(kern: CGFloat?) -> NSAttributedStringBuilder {
        attributes[.kern] = kern
        return self
    }
    
    func underlined() -> NSAttributedStringBuilder {
        attributes[.underlineStyle] = NSUnderlineStyle.single.rawValue
        return self
    }
    
    func getAttributes() -> [NSAttributedString.Key: Any] {
        return attributes
    }
    
    func build() -> NSAttributedString? {
        guard let baseString = baseString else { return nil }
        
        return NSMutableAttributedString(string: baseString, attributes: attributes)
    }
}

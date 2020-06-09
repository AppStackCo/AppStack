//
//  NSAttributedStringBuilder.swift
//  AppStack
//
//  Created by Alin Popa on 24/03/2020.
//  Copyright © 2020 AppStack. All rights reserved.
//

import Foundation
import UIKit

public class NSAttributedStringBuilder {
    private var baseString: String?
    private var attributes: [NSAttributedString.Key: Any] = [:]
    
    public init(baseString: String? = nil) {
        self.baseString = baseString
    }
    
    public func with(font: UIFont) -> NSAttributedStringBuilder {
        attributes[.font] = font
        return self
    }
    
    public func with(foregroundColor: UIColor) -> NSAttributedStringBuilder {
        attributes[.foregroundColor] = foregroundColor
        return self
    }
    
    public func with(kern: CGFloat?) -> NSAttributedStringBuilder {
        attributes[.kern] = kern
        return self
    }
    
    public func with(lineSpacing: CGFloat?) -> NSAttributedStringBuilder {
        if let lineSpacing = lineSpacing {
            let paragraphStyle = attributes[.paragraphStyle] as? NSMutableParagraphStyle ?? NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = lineSpacing
            attributes[.paragraphStyle] = paragraphStyle
        }
        return self
    }
    
    public func underlined() -> NSAttributedStringBuilder {
        attributes[.underlineStyle] = NSUnderlineStyle.single.rawValue
        return self
    }
    
    public func getAttributes() -> [NSAttributedString.Key: Any] {
        return attributes
    }
    
    public func build() -> NSAttributedString? {
        guard let baseString = baseString else { return nil }
        
        return NSMutableAttributedString(string: baseString, attributes: attributes)
    }
}

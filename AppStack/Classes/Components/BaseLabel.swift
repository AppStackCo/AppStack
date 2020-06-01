//
//  BaseLabel.swift
//  abseil
//
//  Created by Marius Gutoi on 02/06/2020.
//

import UIKit

public class BaseLabel: UILabel {
    
    var textStyle: TextStyle2!
    
    public func setText(_ text: String,
                 textStyle newStyle: TextStyle2? = nil,
                 newColor: UIColor? = nil) {
        
        if let newStyle = newStyle {
            textStyle = newStyle
        }
        
        guard let textStyle = textStyle else {
            fatalError("Text style should be set before using setText!!!")
        }
        
        attributedText = textStyle.attributedText(for: text, newColor: newColor)
    }
}

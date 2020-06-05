//
//  UIColor+Extensions.swift
//  abseil
//
//  Created by Marius Gutoi on 05/06/2020.
//

import UIKit

extension UIColor {
    
    /// format #rgba or #rgb
    public convenience init(hex: String) {
        let r, g, b, a: CGFloat
        
        guard hex.hasPrefix("#") else {
            fatalError()
        }
        
        let start = hex.index(hex.startIndex, offsetBy: 1)
        let hexColor = String(hex[start...])
        
        if hexColor.count == 8 {
            let scanner = Scanner(string: hexColor)
            var hexNumber: UInt64 = 0
            
            if scanner.scanHexInt64(&hexNumber) {
                r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                a = CGFloat(hexNumber & 0x000000ff) / 255
                
                self.init(red: r, green: g, blue: b, alpha: a)
                return
            }
        } else if hexColor.count == 6 {
            let scanner = Scanner(string: hexColor)
            var hexNumber: UInt64 = 0
            
            if scanner.scanHexInt64(&hexNumber) {
                r = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                g = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                b = CGFloat(hexNumber & 0x000000ff) / 255
                a = CGFloat(1.0)
                
                self.init(red: r, green: g, blue: b, alpha: a)
                return
            }
        }
        
        fatalError("invalid hex color format - \(hex), should be either #rgba (lenghth 8) or #rgb (length 6)")
    }
}

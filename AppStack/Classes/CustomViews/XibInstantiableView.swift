//
//  XibInstantiableView.swift
//  AppointmentsBO
//
//  Created by Alin Popa on 22/03/2020.
//  Copyright © 2020 AppStack. All rights reserved.
//

import UIKit

protocol XibInstantiableProtocol {
    var xibName: String { get }
    var xibContentView: UIView! { get set }
    func instantiate() -> UIView
}

extension XibInstantiableProtocol where Self: UIView {
    var xibName: String { String(describing: type(of: self)) }
    
    static func instantiateFromNib<T: UIView>() -> T where T: XibInstantiableProtocol {
        T().instantiate() as! T
    }
    
    @discardableResult func instantiate() -> UIView {
        let bundle = Bundle(for: type(of: self))
        bundle.loadNibNamed(xibName, owner: self, options: nil)
        xibContentView.fixInView(self)
        
        return self
    }
}

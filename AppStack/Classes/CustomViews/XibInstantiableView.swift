//
//  XibInstantiableView.swift
//  AppointmentsBO
//
//  Created by Alin Popa on 22/03/2020.
//  Copyright © 2020 AppStack. All rights reserved.
//

import UIKit

public protocol XibInstantiableProtocol {
    var xibName: String { get }
    var xibContentView: UIView! { get set }
    func instantiate() -> UIView
}

public extension XibInstantiableProtocol where Self: UIView {
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

open class InstantiableView: UIView, XibInstantiableProtocol {
    open var xibContentView: UIView!
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        instantiate()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
//        instantiate()
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        instantiate()
    }
}

open class InstantiableTableViewCell: UITableViewCell, XibInstantiableProtocol {
    open var xibContentView: UIView!
    
    open override var contentView: UIView {
        get { xibContentView }
        set { xibContentView = newValue }
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        instantiate()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        instantiate()
    }
}

//
//  TableSectionHeaderView.swift
//  AppointmentsBO
//
//  Created by Alin Popa on 26/04/2020.
//  Copyright © 2020 AppStack. All rights reserved.
//

import RxSwift

class TableSectionHeaderView: UITableViewHeaderFooterView, XibInstantiableProtocol {
    @IBOutlet private var mainView: UIView! {
        get { xibContentView }
        set { xibContentView = newValue }
    }
    @IBOutlet private weak var secondaryView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    
    var xibContentView: UIView!
    
    var model: BaseTableViewSectionViewModel? {
        didSet {
            setupModel()
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        instantiate()
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        instantiate()
    }
    
    private func setupModel() {
        titleLabel.text = model?.title
        
        if let font = model?.titleFont {
            titleLabel.font = font
        }
        
        if let alignment = model?.titleTextAlignment {
            titleLabel.textAlignment = alignment
        }
        
        secondaryView.backgroundColor = model?.backgroundColor ?? .lightGray
    }
}

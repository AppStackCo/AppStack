//
//  TableSectionHeaderView.swift
//  AppointmentsBO
//
//  Created by Alin Popa on 26/04/2020.
//  Copyright © 2020 AppStack. All rights reserved.
//

import UIKit

class TableSectionHeaderView: UITableViewHeaderFooterView, BaseTableViewSectionViewModel {
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    var titleTextAlignment: NSTextAlignment? {
        didSet {
            if let alignment = titleTextAlignment {
                titleLabel.textAlignment = alignment
            }
        }
    }
    
    private var titleLabel = UILabel()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        setupTitleLabel()
    }
    
    private func setupTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.heightAnchor.constraint(equalToConstant: 60),
            titleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}

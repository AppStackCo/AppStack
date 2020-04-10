//
//  UITableView+Extensions.swift
//  AppointmentsBO
//
//  Created by Alin Popa on 11/03/2020.
//  Copyright © 2020 AppStack. All rights reserved.
//

import RxCocoa
import RxDataSources
import UIKit

extension UITableView {
    func setup() {
        dataSource = nil
        alwaysBounceVertical = false
        rowHeight = UITableView.automaticDimension
        sectionHeaderHeight = UITableView.automaticDimension
        estimatedRowHeight = Size.estimatedTableRowHeight.value
        separatorInset = UIEdgeInsets(top: CGFloat(0), left: CGFloat(0), bottom: CGFloat(0), right: CGFloat(0))
        separatorColor = .lightGray
        
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false

        let backgroundView = UIView(frame: self.bounds)
        backgroundView.backgroundColor = .white
        self.backgroundView = backgroundView

        self.tableFooterView = UIView(frame: CGRect.zero)
        self.tableHeaderView = UIView(frame: CGRect.zero)
    }
    
    func setupDefaultDataSource(cellIdentifiers: [String]) -> RxTableViewSectionedReloadDataSource<TableViewSectionModel> {
        let configureCell: RxTableViewSectionedReloadDataSource<TableViewSectionModel>.ConfigureCell = { (_, tableView, indexPath, cellModel) in
            let cell = tableView.dequeueReusableCell(withIdentifier: cellModel.identifier, for: indexPath)
            (cell as? BaseTableViewCell)?.update(using: cellModel)
            
            return cell
        }
                
        let canEditRowAtIndexPath: RxTableViewSectionedReloadDataSource<TableViewSectionModel>.CanEditRowAtIndexPath = { (_, _) in false }
                
        return setupDataSource(cellIdentifiers: cellIdentifiers,
                               configureCell: configureCell,
                               canEditRowAtIndexPath: canEditRowAtIndexPath)
    }
    
    func setupDataSource(cellIdentifiers: [String],
                         configureCell: @escaping RxTableViewSectionedReloadDataSource<TableViewSectionModel>.ConfigureCell,
                         canEditRowAtIndexPath: @escaping RxTableViewSectionedReloadDataSource<TableViewSectionModel>.CanEditRowAtIndexPath)
            -> RxTableViewSectionedReloadDataSource<TableViewSectionModel> {
        cellIdentifiers.forEach { cellIdentifier in
            register(UINib(nibName: cellIdentifier, bundle: Bundle(for: type(of: self))), forCellReuseIdentifier: cellIdentifier)
        }
                
        return .init(configureCell: configureCell, canEditRowAtIndexPath: canEditRowAtIndexPath)
    }
}

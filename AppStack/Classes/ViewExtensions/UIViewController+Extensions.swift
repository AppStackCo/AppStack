//
//  UIViewController+Extensions.swift
//  AppointmentsBO
//
//  Created by Alin Popa on 09/03/2020.
//  Copyright © 2020 AppStack. All rights reserved.
//

import RxDataSources
import RxSwift
import UIKit

extension UIViewController {
    class var storyboardIdentifier: String { String(describing: self) }
    
    public static func instantiateFromStoryboard(storyboard: UIStoryboard) -> Self {
        storyboard.instantiateViewControllerClass(viewControllerClass: self)
    }
    
    public func setupTableViewDataSource(tableView: UITableView, cellIdentifiers: [String], dataSource: inout RxTableViewSectionedReloadDataSource<TableViewSectionModel>?, disposeBag: DisposeBag) {
        tableView.setup()
        view.setupTableViewDataSource(tableView: tableView, cellIdentifiers: cellIdentifiers, dataSource: &dataSource, disposeBag: disposeBag)
    }
}

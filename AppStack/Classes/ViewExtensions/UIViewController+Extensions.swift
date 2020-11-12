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
        
        cellIdentifiers.forEach { cellIdentifier in
            tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        }
        
        let configureCell: RxTableViewSectionedReloadDataSource<TableViewSectionModel>.ConfigureCell = { (_, tableView, indexPath, cellModel) in
            let cell = tableView.dequeueReusableCell(withIdentifier: cellModel.identifier, for: indexPath)
            (cell as? BaseTableViewCell)?.update(using: cellModel)
            
            return cell
        }
        
        let canEditRowAtIndexPath: RxTableViewSectionedReloadDataSource<TableViewSectionModel>.CanEditRowAtIndexPath = { (_, _) in false }
        
        dataSource = .init(configureCell: configureCell,
                           canEditRowAtIndexPath: canEditRowAtIndexPath)
        
        tableView.rx.modelSelected(BaseTableViewCellViewModel.self)
            .subscribe(onNext: { model in
                (model as? SelectableTableViewCellViewModel)?.selectedAction.execute()
            })
            .disposed(by: disposeBag)
        
        // This adds the visual effect of de-selecting a row once touchUp has been fired.
        tableView.rx
            .itemSelected
            .subscribe(onNext: { indexPath in
                tableView.deselectRow(at: indexPath, animated: true)
            })
            .disposed(by: disposeBag)
    }
}

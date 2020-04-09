//
//  BaseTableViewController.swift
//  AppointmentsBO
//
//  Created by Alin Popa on 09/03/2020.
//  Copyright © 2020 AppStack. All rights reserved.
//

import RxDataSources
import RxSwift
import UIKit

open class BaseTableViewController<ViewModel: TableViewViewModelProtocol & LoadingStateViewModel>: UITableViewController, UIGestureRecognizerDelegate,
                                DisposableProtocol, BindableViewController {
    public let disposeBag = DisposeBag()
    public var viewModel: ViewModel!
    var dataSource: RxTableViewSectionedReloadDataSource<TableViewSectionModel>!
    
    public var manuallyLoadView: Bool { false }
    
    open var cellIdentifiers: [String] { [] }
    
    var canEditRowAtIndexPath: ((IndexPath) -> Bool) { { (_) in true } }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        bindViewModel()
        setupLoading()
        
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    open func bindViewModel() {
        viewModel.tableItems()
            .drive(tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
    
    private func setupTableView() {
        tableView.setup()
        
        cellIdentifiers.forEach { cellIdentifier in
            tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        }
        
        let configureCell: RxTableViewSectionedReloadDataSource<TableViewSectionModel>.ConfigureCell = { (_, tableView, indexPath, cellModel) in
            let cell = tableView.dequeueReusableCell(withIdentifier: cellModel.identifier, for: indexPath)
            (cell as? BaseTableViewCell)?.update(using: cellModel)
            
            return cell
        }
        
        let canEditRowAtIndexPath: RxTableViewSectionedReloadDataSource<TableViewSectionModel>.CanEditRowAtIndexPath = { [weak self] (_, indexPath) in
            self?.canEditRowAtIndexPath(indexPath) ?? false
        }
        
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
            .subscribe(onNext: { [weak self] indexPath in
                self?.tableView.deselectRow(at: indexPath, animated: true)
            })
            .disposed(by: disposeBag)
    }
}

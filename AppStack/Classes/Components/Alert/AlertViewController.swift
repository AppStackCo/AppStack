//
//  AlertViewController.swift
//  AppointmentsBO
//
//  Created by Alin Popa on 22/03/2020.
//  Copyright © 2020 AppStack. All rights reserved.
//

import Jelly
import RxDataSources

class AlertViewController: DisposableViewController, BindableViewController, AnimatorControllerProtocol {
    var viewModel: AlertViewModel!
    weak var animator: Animator?
    
    private var tableViewCellIdentifiers: [String] {
        [AlertTextTableViewCell.identifier,
         ButtonTableViewCell.identifier]
    }
    private var tableViewDataSource: RxTableViewSectionedReloadDataSource<TableViewSectionModel>!
    @IBOutlet private weak var tableView: SelfSizedTableView!
    
    override func viewDidLoad() {
        setupTableView()
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        try? animator?.updateSize(presentationSize: PresentationSize(width: .fullscreen, height: .custom(value: getTableViewHeight())), duration: .reallyFast)
    }
    
    func bindViewModel() {
        viewModel.tableItems()
            .drive(tableView.rx.items(dataSource: tableViewDataSource))
            .disposed(by: disposeBag)
    }
    
    func getInitialContentHeight() -> CGFloat {
        tableView.reloadData()
        tableView.layoutIfNeeded()
        
        return getTableViewHeight()
    }
    
    private func setupTableView() {
        tableView.setup()
        tableViewDataSource = tableView.setupDefaultDataSource(cellIdentifiers: tableViewCellIdentifiers)
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
    }
    
    private func getTableViewHeight() -> CGFloat {
        tableView.contentSize.height + tableView.contentInset.bottom + tableView.contentInset.top
    }
}

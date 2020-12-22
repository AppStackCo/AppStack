//
//  ViewControllerWithSectionedTable.swift
//  AppStack
//
//  Created by Alin Popa on 22/12/2020.
//

import RxCocoa
import RxDataSources
import RxSwift

open class ViewControllerWithSectionedTable: UIViewController {
    @IBOutlet open weak var tableView: UITableView!
    
    open var dataSource: RxTableViewSectionedReloadDataSource<TableViewSectionModel>!
    
    open var sectionIdentifier: String { String(describing: TableSectionHeaderView.self) }
    open var sectionsDriver: Driver<[TableViewSectionModel]>!
    open var sectionHeight: CGFloat = 60
    
    public let disposeBag = DisposeBag()
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.register(TableSectionHeaderView.self, forHeaderFooterViewReuseIdentifier: sectionIdentifier)
        
        sectionsDriver
            .drive(tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
}

extension ViewControllerWithSectionedTable: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if dataSource.sectionModels.count > section, let title = dataSource.sectionModels[section].model.title {
            return title.isEmpty ? CGFloat.leastNormalMagnitude : sectionHeight
        }
        
        return CGFloat.leastNormalMagnitude
    }

    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: sectionIdentifier) as? TableSectionHeaderView {
            view.model = dataSource.sectionModels[section].model
            
            return view
        }
        
        return nil
    }
}

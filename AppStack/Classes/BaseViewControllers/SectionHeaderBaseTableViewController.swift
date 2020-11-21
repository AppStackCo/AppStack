//
//  SectionHeaderBaseTableViewController.swift
//  AppointmentsBO
//
//  Created by Alin Popa on 26/04/2020.
//  Copyright © 2020 AppStack. All rights reserved.
//

import UIKit

open class SectionHeaderBaseTableViewController<VM: ViewModelProtocol & ScreenFlowViewModel & TableViewViewModelProtocol>: ScreenFlowTableViewController<VM> {
    var sectionIdentifier: String { String(describing: TableSectionHeaderView.self) }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(TableSectionHeaderView.self, forHeaderFooterViewReuseIdentifier: sectionIdentifier)
    }
    
    public override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if let title = dataSource.sectionModels[section].model.title {
            return title.isEmpty ? CGFloat.leastNormalMagnitude : UITableView.automaticDimension
        }
        
        return UITableView.automaticDimension
    }
    
    public override func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        60
    }
    
    public override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: sectionIdentifier) as? TableSectionHeaderView {
            let title = dataSource.sectionModels[section].model.title
            view.title = title
            view.titleTextAlignment = dataSource.sectionModels[section].model.titleTextAlignment
            
            return view
        }
        
        return nil
    }
    
    public override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.isHidden = tableView.indexPathsForVisibleRows?.isEmpty == true
    }
}

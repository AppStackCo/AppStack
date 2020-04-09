//
//  BaseTableViewSectionViewModel.swift
//  AppointmentsBO
//
//  Created by Alin Popa on 09/03/2020.
//  Copyright © 2020 AppStack. All rights reserved.
//

import RxDataSources

public protocol BaseTableViewSectionViewModel {
    var title: String? { get }
}

public struct TableViewSectionViewModel: BaseTableViewSectionViewModel {
    public let title: String?
}

public typealias TableViewSectionModel = SectionModel<BaseTableViewSectionViewModel, BaseTableViewCellViewModel>

extension TableViewSectionModel {
    public static func withItems(_ items: [BaseTableViewCellViewModel]) -> TableViewSectionModel {
        return TableViewSectionModel(model: TableViewSectionViewModel(title: ""), items: items)
    }
}

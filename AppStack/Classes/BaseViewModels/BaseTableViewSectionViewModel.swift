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
    var titleTextAlignment: NSTextAlignment? { get }
    var backgroundColor: UIColor { get }
}

public struct TableViewSectionViewModel: BaseTableViewSectionViewModel {
    public let title: String?
    public let titleTextAlignment: NSTextAlignment?
    public let backgroundColor: UIColor
    
    public init(title: String?, titleTextAlignment: NSTextAlignment = .left, backgroundColor: UIColor = .black) {
        self.title = title
        self.titleTextAlignment = titleTextAlignment
        self.backgroundColor = backgroundColor
    }
}

public typealias TableViewSectionModel = SectionModel<BaseTableViewSectionViewModel, BaseTableViewCellViewModel>

extension TableViewSectionModel {
    public static func withItems(_ items: [BaseTableViewCellViewModel]) -> TableViewSectionModel {
        return TableViewSectionModel(model: TableViewSectionViewModel(title: nil), items: items)
    }
}

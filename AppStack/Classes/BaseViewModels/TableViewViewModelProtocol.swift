//
//  BaseTableViewViewModel.swift
//  AppointmentsBO
//
//  Created by Alin Popa on 09/03/2020.
//  Copyright © 2020 AppStack. All rights reserved.
//

import RxCocoa
import RxDataSources

public protocol TableViewViewModelProtocol: ViewModelProtocol {
    func tableItems() -> Driver<[TableViewSectionModel]>
}

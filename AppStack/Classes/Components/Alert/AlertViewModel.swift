//
//  AlertViewModel.swift
//  AppointmentsBO
//
//  Created by Alin Popa on 22/03/2020.
//  Copyright © 2020 AppStack. All rights reserved.
//

import Action
import RxCocoa

class AlertViewModel: BaseViewModel<AlertNavigator>, ScreenFlowViewModel, TableViewViewModelProtocol {
    private let alertControllerModel: AlertControllerModel
    
    required init(navigator: AlertNavigator) {
        fatalError("init(navigator:) has not been implemented")
    }
    
    init(navigator: AlertNavigator, inputData: AlertControllerModel) {
        self.alertControllerModel = inputData
        super.init(navigator: navigator)
    }
    
    func tableItems() -> Driver<[TableViewSectionModel]> {
        var items: [BaseTableViewCellViewModel] = []
        
        if let title = alertControllerModel.title {
            items.append(AlertTextCellViewModel(text: title, textStyle: .alertTitle))
        }
        
        if let message = alertControllerModel.message {
            items.append(AlertTextCellViewModel(text: message, textStyle: .alertMessage))
        }
        
        items.append(contentsOf: alertControllerModel.actions.map { action -> ButtonCellViewModel in
            ButtonCellViewModel(title: action.title, action: CocoaAction { [unowned self] in
                guard action.shouldDismissOnTapAction else {
                    action.tapAction?.execute()
                    
                    return .empty()
                }
                
                self.navigator.dismiss {
                    action.tapAction?.execute()
                }
                
                return .empty()
            })
        })
        
        return .just([.withItems(items)])
    }
}

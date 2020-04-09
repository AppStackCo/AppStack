//
//  AlertControllerModel.swift
//  AppointmentsBO
//
//  Created by Alin Popa on 22/03/2020.
//  Copyright © 2020 AppStack. All rights reserved.
//

import Foundation
import Action

public enum AlertActionStyle: Int {
    case `default`
    case cancel
    case destructive
    
    func toSystemStyle() -> UIAlertAction.Style {
        switch self {
        case .default:
            return .default
        case .cancel:
            return .cancel
        case .destructive:
            return .destructive
        }
    }
}

public enum AlertControllerStyle: Int {
    case actionSheet
    case alert
    
    func toSystemStyle() -> UIAlertController.Style {
        switch self {
        case .actionSheet:
            return .actionSheet
        case .alert:
            return .alert
        }
    }
}

public struct AlertActionModel {
    let title: String
    let style: AlertActionStyle
    let shouldDismissOnTapAction: Bool
    let tapAction: CocoaAction?
    
    public init(title: String, style: AlertActionStyle, shouldDismissOnTapAction: Bool = true, tapAction: CocoaAction? = nil) {
        self.title = title
        self.style = style
        self.shouldDismissOnTapAction = shouldDismissOnTapAction
        self.tapAction = tapAction
    }
}

public struct AlertControllerModel {
    let title: String?
    let message: String?
    let style: AlertControllerStyle
    let actions: [AlertActionModel]
    let isTapBackgroundToDismissEnabled: Bool
    
    public init(title: String? = nil, message: String? = nil, isTapBackgroundToDismissEnabled: Bool = true,
         style: AlertControllerStyle, actions: [AlertActionModel]) {
        self.title = title
        self.message = message
        self.isTapBackgroundToDismissEnabled = isTapBackgroundToDismissEnabled
        self.style = style
        self.actions = actions
    }
}

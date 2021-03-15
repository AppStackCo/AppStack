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

open class AlertActionModel {
    public let title: String
    public let style: AlertActionStyle
    public let shouldDismissOnTapAction: Bool
    public let tapAction: CocoaAction?
    
    public init(title: String, style: AlertActionStyle, shouldDismissOnTapAction: Bool = true, tapAction: CocoaAction? = nil) {
        self.title = title
        self.style = style
        self.shouldDismissOnTapAction = shouldDismissOnTapAction
        self.tapAction = tapAction
    }
}

public struct AlertControllerModel {
    public let title: String?
    public let message: String?
    public let style: AlertControllerStyle
    public let actions: [AlertActionModel]
    public let isTapBackgroundToDismissEnabled: Bool
    
    public init(title: String? = nil, message: String? = nil, isTapBackgroundToDismissEnabled: Bool = true, style: AlertControllerStyle, actions: [AlertActionModel]) {
        self.title = title
        self.message = message
        self.isTapBackgroundToDismissEnabled = isTapBackgroundToDismissEnabled
        self.style = style
        self.actions = actions
    }
}

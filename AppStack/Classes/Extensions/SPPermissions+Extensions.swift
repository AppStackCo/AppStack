//
//  SPPermissions+Extensions.swift
//  AppointmentsBO
//
//  Created by Alin Popa on 20/04/2020.
//  Copyright © 2020 AppStack. All rights reserved.
//

import SPPermissions

extension SPPermission {
    
    public enum PermissionState {
        case authorized
        case notAuthorized
        case denied
    }
    
    public func state() -> PermissionState {
        isDenied ? .denied : isAuthorized ? .authorized : .notAuthorized
    }
}

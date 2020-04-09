//
//  DisposableViewController.swift
//  AppointmentsBO
//
//  Created by Alin Popa on 11/03/2020.
//  Copyright © 2020 AppStack. All rights reserved.
//

import RxSwift

protocol DisposableProtocol {
    var disposeBag: DisposeBag { get }
}

open class DisposableViewController: UIViewController, DisposableProtocol {
    public let disposeBag = DisposeBag()
}

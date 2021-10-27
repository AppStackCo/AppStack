//
//  Coordinator.swift
//  DemoArchitecture
//
//  Created by Marius Gutoi on 07/02/2019.
//  Copyright © 2019 Marius Gutoi. All rights reserved.
//

import RxSwift
import UIKit

public protocol CoordinatorType: AnyObject {
    var childCoordinators: [CoordinatorType] { get }
    var parentCoordinator: CoordinatorType? { get set }
    
//    func start()
    func start(coordinator: CoordinatorType)
    
    // debug
    func dump(depth: Int)
}

public protocol Containable {
    associatedtype Container: AnyObject
    var container: Container! { get set }
}

open class Coordinator<Container: AnyObject>: CoordinatorType, Containable {
    
    public let disposeBag = DisposeBag()
    
    public weak var container: Container! // TODO - check if we can remove implicit unwrap
    
    open var childCoordinators: [CoordinatorType] {
        fatalError("You should override childCoordinators in \(String(describing: self)) !!!")
    }
    public weak var parentCoordinator: CoordinatorType?
    
//    func start() {
//        fatalError("Start method should be implemented.")
//    }
    
    public func start(coordinator: CoordinatorType) {
        coordinator.parentCoordinator = self
//        coordinator.start()
    }
}

extension Coordinator where Container: UIViewController {

    /// end current coordinator if it was presented modally
    func endModal() {
        guard let presenter = container.presentingViewController else {
            print("this coordinator was not presented modally")
            return
        }
        presenter.dismiss(animated: true) {
            /// break link to container
            self.container = nil
        }
    }
}

// DEBUG

//extension Coordinator: CustomDebugStringConvertible {
//    var debugDescription: String {
//        return "(\(String(describing:self)))"
//    }
//}

extension Coordinator {
    
    var address: String {
        return "\(Unmanaged.passUnretained(self).toOpaque())"
    }
    
    public func dump(depth: Int = 0) {
        var indentation: String = ""
        (0..<depth).forEach { _ in indentation += "    " }
        print("\(indentation)\(self)")
        
        childCoordinators.forEach { coordinator in
            coordinator.dump(depth: depth + 1)
        }
    }
}

//
//  UIKitExtensions.swift
//  RxDataSources
//
//  Created by Segii Shulga on 4/26/16.
//  Copyright © 2016 kzaher. All rights reserved.
//

import class UIKit.UITableViewCell
import class UIKit.UITableView
import struct Foundation.IndexPath

public protocol ReusableView: AnyObject {
    static var reuseIdentifier: String {get}
}

extension ReusableView {
    public static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReusableView {
}

// MARK: UITableViewCell
extension ReusableView where Self: UITableViewCell {
    
    public static func dequeue(
        from tableView: UITableView,
        at indexPath: IndexPath,
        identifier: String = Self.reuseIdentifier) -> Self {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        if let expectedCell = cell as? Self {
            return expectedCell
        }
        
        fatalError("TableViewCell is not of exepected type, got \(String(describing: cell)) expected \(String(describing: Self.self))")
    }
    
    static func register(in tableView: UITableView, with identifier: String = Self.reuseIdentifier) {
        tableView.register(Self.self, forCellReuseIdentifier: identifier)
    }
}

//extension UITableView {
//
//    func dequeueReusableCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T {
//        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
//            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
//        }
//
//        return cell
//    }
//}

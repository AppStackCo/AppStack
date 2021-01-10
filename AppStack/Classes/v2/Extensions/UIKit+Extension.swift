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

extension UITableViewCell: ReusableView {}

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
    
    public static func register(in tableView: UITableView, with identifier: String = Self.reuseIdentifier) {
        tableView.register(Self.self, forCellReuseIdentifier: identifier)
    }
}

extension UICollectionViewCell: ReusableView {}

// MARK: UICollectionViewCell
extension ReusableView where Self: UICollectionViewCell {
    
    public static func dequeue(
        from collectionView: UICollectionView,
        at indexPath: IndexPath,
        identifier: String = Self.reuseIdentifier) -> Self {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        if let expectedCell = cell as? Self {
            return expectedCell
        }
        
        fatalError("CollectionViewCell is not of exepected type, got \(String(describing: cell)) expected \(String(describing: Self.self))")
    }
    
    public static func register(in collectionView: UICollectionView, with identifier: String = Self.reuseIdentifier) {
        collectionView.register(Self.self, forCellWithReuseIdentifier: identifier)
    }
}

public protocol NibInitializable {
//    static func instantitate() -> Self
}

extension NibInitializable where Self: UIView {
    static var nibName: String {
        return String(describing: Self.self)
    }
    
    static var nibBundle: Bundle? {
        return Bundle(for: Self.self)
    }
    
    static var nib: UINib {
        return UINib(nibName: nibName, bundle: nibBundle)
    }
    
//    static func instantiate() -> Self {
//        guard let view = nib.instantiate(withOwner: nil, options: nil).first as? Self else {
//            fatalError("Could not instantiate view from nib with name \(nibName).")
//        }
//        return view
//    }
}

extension ReusableView where Self: UITableViewCell & NibInitializable {
    public static func register(in tableView: UITableView, with identifier: String = Self.reuseIdentifier) {
        tableView.register(Self.nib, forCellReuseIdentifier: identifier)
    }
}

//
//  WeakArray.swift
//  DemoArchitecture
//
//  Created by Marius Gutoi on 10/02/2019.
//  Copyright © 2019 Marius Gutoi. All rights reserved.
//
//  Source: https://www.objc.io/blog/2017/12/28/weak-arrays/
//

import Foundation

final class WeakBox<A: AnyObject> {
    weak var unbox: A?
    init(_ value: A) {
        unbox = value
    }
}

struct WeakArray<T: AnyObject> {
    private var items: [WeakBox<T>] = []
    
    init(_ elements: [T]) {
        items = elements.map { WeakBox($0) }
    }
}

extension WeakArray: Collection {
    var startIndex: Int { return items.startIndex }
    var endIndex: Int { return items.endIndex }
    
    subscript(_ index: Int) -> T? {
        return items[index].unbox
    }
    
    func index(after idx: Int) -> Int {
        return items.index(after: idx)
    }
}

extension WeakArray {
    mutating func append(_ newElement: T) {
        items.append(WeakBox(newElement))
    }
}

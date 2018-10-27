//
//  StorageRepositoring.swift
//  AuthTemplate
//
//  Created by Taras Didukh on 10/27/18.
//  Copyright © 2018 Freeman. All rights reserved.
//

import Foundation
import RealmSwift
import ReactiveSwift
import Result

protocol Storable {}
extension Object: Storable {
}
protocol StorageRepositoring {

    func getFirst<T: Storable>(_ model: T.Type) -> Storable?
    func add(model: Storable)
    func delete(model: Storable)
    func dropDatabase()
}

//
//  RealmRepository.swift
//  AuthTemplate
//
//  Created by Taras Didukh on 10/27/18.
//  Copyright © 2018 Freeman. All rights reserved.
//

import Foundation
import RealmSwift
import ReactiveSwift
import ReactiveCocoa
import Result

class RealmRepository: StorageRepositoring {
    
    var realm: Realm
    
    init() {
        self.realm = try! Realm()
    }
    
    func getFirst<T: Storable>(_ model: T.Type) -> Storable? {
        return self.realm.objects(model as! Object.Type).first
    }
    
    func add(model: Storable) {
        try! self.realm.write {
            self.realm.add(model as! Object, update: true)
        }
    }
    func delete(model: Storable) {
        try! self.realm.write {
            self.realm.delete(model as! Object)
        }
    }
    
    func dropDatabase() {
        try! self.realm.write {
            self.realm.deleteAll()
        }
    }
}

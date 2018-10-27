//
//  AuthService.swift
//  AuthTemplate
//
//  Created by Taras Didukh on 10/27/18.
//  Copyright © 2018 Freeman. All rights reserved.
//

import Foundation
import ReactiveSwift
import Result

public final class AuthService : AuthServicing {
    private var storage: StorageRepositoring
    
    init(storage: StorageRepositoring) {
        self.storage = storage
    }
    
    func checkAuthentication() -> User? {
        return storage.getFirst(User.self) as? User
    }
    func singOut() -> SignalProducer<(), NoError> {
        return SignalProducer { observer, disposable in
            if let user = self.storage.getFirst(User.self) {
                self.storage.delete(model: user)
            }
            observer.sendCompleted()
        }
    }
    func prepareSignIn() {
        storage.dropDatabase()
    }
}

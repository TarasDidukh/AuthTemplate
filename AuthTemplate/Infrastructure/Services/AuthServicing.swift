//
//  AuthServicing.swift
//  AuthTemplate
//
//  Created by Taras Didukh on 10/27/18.
//  Copyright © 2018 Freeman. All rights reserved.
//

import Foundation
import Foundation
import ReactiveSwift
import Result

protocol AuthServicing {
    func checkAuthentication() -> User?
    func singOut() -> SignalProducer<(), NoError>
    func prepareSignIn()
}

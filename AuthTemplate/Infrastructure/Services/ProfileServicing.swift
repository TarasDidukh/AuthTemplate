//
//  ProfileServicing.swift
//  AuthTemplate
//
//  Created by Taras Didukh on 10/27/18.
//  Copyright © 2018 Freeman. All rights reserved.
//

import Foundation
import ReactiveSwift

protocol ProfileServicing {
    func getMyProfile() -> SignalProducer<User?, NetworkError>
}

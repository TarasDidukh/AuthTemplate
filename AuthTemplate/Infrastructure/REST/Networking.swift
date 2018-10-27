//
//  Networking.swift
//  AuthTemplate
//
//  Created by Taras Didukh on 10/27/18.
//  Copyright © 2018 Freeman. All rights reserved.
//

import ReactiveSwift
import Result

protocol Networking {
    func get<TResponse: Codable>(_ url: String, parameters: [String: String]?) -> SignalProducer<TResponse, NetworkError>
}

//
//  ProfileService.swift
//  AuthTemplate
//
//  Created by Taras Didukh on 10/27/18.
//  Copyright © 2018 Freeman. All rights reserved.
//

import Foundation
import ReactiveSwift

public final class ProfileService : ProfileServicing {
    private var network: Networking
    private var storage: StorageRepositoring
    
    init(network: Networking, storage: StorageRepositoring) {
        self.network = network
        self.storage = storage
    }
    
    func getMyProfile() -> SignalProducer<User?, NetworkError> {
        let url = "\(Constants.BaseUrl)users/2"
        let producer: SignalProducer<UserResult, NetworkError> = network.get(url, parameters: nil)
        
        return producer.on(value: { result in
            if let user = result.data {
                self.storage.add(model: user)
            }
        }).map{ $0.data }
    }
}

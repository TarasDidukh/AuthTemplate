//
//  Network.swift
//  AuthTemplate
//
//  Created by Taras Didukh on 10/27/18.
//  Copyright © 2018 Freeman. All rights reserved.
//

import ReactiveSwift
import Foundation
import Alamofire
import Result

public final class Network : Networking {
    
    func get<TResponse : Codable>(_ url: String, parameters: [String: String]?) -> SignalProducer<TResponse, NetworkError> {
        return SignalProducer { observer, disposable in
            Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding(destination: .queryString))
                .responseJSON{ response in
                    self.handleResult(observer, response)
            }
        }
    }
    
    func handleResult<TResponse: Codable>(_ observer: Signal<TResponse, NetworkError>.Observer, _ response: DataResponse<Any>) {
        switch response.result {
        case .success:
            do {
                let result = try JSONDecoder().decode(TResponse.self, from: response.data!)
                observer.send(value: result)
            }catch {
                observer.send(error: NetworkError.Unknown)
            }
            observer.sendCompleted()
        case .failure(let error):
            observer.send(error: NetworkError(error: error as NSError))
        }
    }
    
    
}

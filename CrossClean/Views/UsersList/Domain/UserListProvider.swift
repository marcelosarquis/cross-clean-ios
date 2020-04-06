//
//  UserListProvider.swift
//  SimplefiedCleanApp
//
//  Created by Marcelo Sarquis on 01.04.20.
//  Copyright © 2020 10s. All rights reserved.
//

import Foundation
import Autobahn

final class UserListProvider: UserListProviderProtocol {
    
    private let network: NetworkProtocol
    init(network: NetworkProtocol = Network()) {
        self.network = network
    }
    
    func fetch(completion: @escaping (Result<[User], Error>) -> Void) {
        let request = UserRequest()
        network.send(request: request) { result in
            switch result {
            case let .success(response):
                completion(.success(response))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}

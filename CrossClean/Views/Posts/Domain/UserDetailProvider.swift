//
//  UserDetailProvider.swift
//  CrossClean
//
//  Created by Marcelo Sarquis on 02.04.20.
//  Copyright © 2020 10s. All rights reserved.
//

import Foundation
import Autobahn

final class UserDetailProvider: UserDetailUseCase {
    
    private let network: NetworkProtocol
    init(network: NetworkProtocol = Network()) {
        self.network = network
    }
    
    func fetchPost(from userId: String, completion: @escaping (Result<[Post], Error>) -> Void) {
        let request = PostRequest(userId: userId)
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

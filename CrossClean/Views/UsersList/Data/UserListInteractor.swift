//
//  UserListInteractor.swift
//  CrossClean
//
//  Created by Marcelo Sarquis on 06.04.20.
//  Copyright © 2020 10s. All rights reserved.
//

import Foundation

final class UserListInteractor: UserListUseCase {
    
    private let userListProvider: UserListProviderProtocol
    public init(userListProvider: UserListProviderProtocol) {
        self.userListProvider = userListProvider
    }
    
    func fetch(completion: @escaping (Result<[User], Error>) -> Void) {
        userListProvider.fetch { result in
            switch result {
            case let .success(users):
                let filteredUsers = users.filter { $0.email.contains("biz") }
                completion(.success(filteredUsers))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}

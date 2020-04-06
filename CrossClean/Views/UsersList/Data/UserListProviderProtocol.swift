//
//  UserListProviderProtocol.swift
//  CrossClean
//
//  Created by Marcelo Sarquis on 06.04.20.
//  Copyright © 2020 10s. All rights reserved.
//

import Foundation

protocol UserListProviderProtocol {
    func fetch(completion: @escaping (Result<[User], Error>) -> Void)
}

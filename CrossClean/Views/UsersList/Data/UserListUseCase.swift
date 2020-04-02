//
//  UserListUseCase.swift
//  SimplefiedCleanApp
//
//  Created by Marcelo Sarquis on 01.04.20.
//  Copyright © 2020 10s. All rights reserved.
//

import Foundation

protocol UserListUseCase {
    func fetch(completion: @escaping (Result<[User], Error>) -> Void)
}

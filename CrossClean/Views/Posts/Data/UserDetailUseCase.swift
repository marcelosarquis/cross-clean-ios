//
//  UserDetailUseCase.swift
//  CrossClean
//
//  Created by Marcelo Sarquis on 02.04.20.
//  Copyright © 2020 10s. All rights reserved.
//

import Foundation

protocol UserDetailUseCase {
    func fetchPost(from userId: String, completion: @escaping (Result<[Post], Error>) -> Void)
}

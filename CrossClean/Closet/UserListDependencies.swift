//
//  UserListDependencies.swift
//  SimplefiedCleanApp
//
//  Created by Marcelo Sarquis on 01.04.20.
//  Copyright © 2020 10s. All rights reserved.
//

import UIKit

final class UserListDependencies: UserListCoordinatorDependencies {
    
    let userListProvider = UserListProvider()
    lazy var userListUseCase: UserListUseCase = UserListInteractor(userListProvider: userListProvider)
    
    lazy var userDetailUseCase: UserDetailUseCase = UserDetailProvider()
}

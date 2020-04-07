//
//  UserListCoordinator.swift
//  SimplefiedCleanApp
//
//  Created by Marcelo Sarquis on 01.04.20.
//  Copyright © 2020 10s. All rights reserved.
//

import Foundation
import UIKit

protocol UserListCoordinatorDependencies: UsersListViewControllerDependencies, UserDetailViewControllerDependencies {}

class UserListCoordinator {
    
    private let window: UIWindow
    private let dependencies: UserListCoordinatorDependencies
    private let navigation: UINavigationController
    convenience init(dependencies: UserListCoordinatorDependencies) {
        self.init(window: UIWindow(frame: UIScreen.main.bounds), dependencies: dependencies)
    }

    init(window: UIWindow, dependencies: UserListCoordinatorDependencies) {
        self.window = window
        self.dependencies = dependencies
        navigation = UINavigationController()
    }

    func start() {
        let usersListViewController = UsersListViewController(dependencies: dependencies)
        usersListViewController.delegate = self
        navigation.viewControllers = [usersListViewController]
        navigation.navigationBar.prefersLargeTitles = true
        window.makeKeyAndVisible()
        window.rootViewController = navigation
    }
}

extension UserListCoordinator: UsersListViewControllerDelegate {
    
    func usersViewControlleDidFinish(with error: Error) {
        print(error) // handle error
    }
    
    func usersViewControlleDidSelect(_ user: User) {
        let userDetailViewController = UserDetailViewController(dependencies: dependencies, user: user)
        userDetailViewController.delegate = self
        navigation.pushViewController(userDetailViewController, animated: true)
    }
}

extension UserListCoordinator: UserDetailViewControllerDelegate {
    func detailsViewControlleDidFinish(with error: Error) {
        print(error) // handle error
    }
}

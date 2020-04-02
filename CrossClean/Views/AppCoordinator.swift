//
//  AppCoordinator.swift
//  SimplefiedCleanApp
//
//  Created by Marcelo Sarquis on 01.04.20.
//  Copyright © 2020 10s. All rights reserved.
//

import Foundation
import UIKit

protocol AppCoordinatorDependencies: UsersListViewControllerDependencies, UserDetailViewControllerDependencies {}

class AppCoordinator {
    
    private let window: UIWindow
    private let dependencies: AppCoordinatorDependencies
    private let navigation: UINavigationController
    convenience init(dependencies: AppCoordinatorDependencies) {
        self.init(window: UIWindow(frame: UIScreen.main.bounds), dependencies: dependencies)
    }

    init(window: UIWindow, dependencies: AppCoordinatorDependencies) {
        self.window = window
        self.dependencies = dependencies
        navigation = UINavigationController()
    }

    func start() {
        let usersListViewController = UsersListViewController(dependencies: dependencies)
        usersListViewController.delegate = self
        navigation.viewControllers = [usersListViewController]
        window.makeKeyAndVisible()
        window.rootViewController = navigation
    }
}

extension AppCoordinator: UsersListViewControllerDelegate {
    
    func usersViewControlleDidFinish(with error: Error) {
        print(error) // handle error
    }
    
    func usersViewControlleDidSelect(_ user: User) {
        let userDetailViewController = UserDetailViewController(dependencies: dependencies, user: user)
        userDetailViewController.delegate = self
        navigation.pushViewController(userDetailViewController, animated: true)
    }
}

extension AppCoordinator: UserDetailViewControllerDelegate {
    func detailsViewControlleDidFinish(with error: Error) {
        print(error) // handle error
    }
}

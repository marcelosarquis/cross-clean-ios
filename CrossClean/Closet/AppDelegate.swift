//
//  AppDelegate.swift
//  SimplefiedCleanApp
//
//  Created by Marcelo Sarquis on 01.04.20.
//  Copyright © 2020 10s. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    private var userListCoordinator: UserListCoordinator!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        userListCoordinator = UserListCoordinator(dependencies: UserListDependencies())
        userListCoordinator.start()
        
        return true
    }
}


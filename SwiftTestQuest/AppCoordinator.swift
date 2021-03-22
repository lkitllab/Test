//
//  AppCoordinator.swift
//  SwiftTestQuest
//
//  Created by Kit on 3/22/21.
//

import UIKit


class AppCoordinator: Coordinator {
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let navigationController = UINavigationController()
        navigationController.isNavigationBarHidden = true
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        let signInCoordinator = SignInCoordinator(navigationController: navigationController)
        signInCoordinator.start()
    }
}

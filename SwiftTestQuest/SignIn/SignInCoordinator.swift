//
//  LoginCoordinator.swift
//  SwiftTestQuest
//
//  Created by Kit on 3/22/21.
//

import UIKit

protocol LoginFlow: class {
    func login()
}

class SignInCoordinator: Coordinator {
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let signInViewController = AppContainer.sigInViewController()
        signInViewController.coordinator = self
        navigationController.pushViewController(signInViewController, animated: true)
    }
}

extension SignInCoordinator: LoginFlow {
    func login() {
        let startCoordinator = StartCoordinator(navigationController: navigationController)
        startCoordinator.start()
    }
}

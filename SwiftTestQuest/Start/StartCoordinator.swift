//
//  StartCoordinator.swift
//  SwiftTestQuest
//
//  Created by Kit on 3/22/21.
//

import UIKit


class StartCoordinator: Coordinator {
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let startViewController = StartViewController()
        startViewController.coordinator = self
        navigationController.pushViewController(startViewController, animated: true)
    }
}

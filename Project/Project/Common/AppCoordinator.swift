//
//  AppCoordinator.swift
//  Project
//
//  Created by user on 15.08.2022.
//

import UIKit

final class AppCoordinator: Coordinator {
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []

    init (navigationController: UINavigationController) {
        self.navigationController = navigationController
        navigationController.setNavigationBarHidden(true, animated: false)
    }

    func start() {
        let tabBarCoordinator = TabBarCoordinator(navigationController)
        store(coordinator: tabBarCoordinator)
        tabBarCoordinator.start()
    }
}

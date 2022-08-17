//
//  TabBarCoordinator.swift
//  Project
//
//  Created by user on 15.08.2022.
//

import UIKit

class TabBarCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var tabBarController: UITabBarController

    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.tabBarController = TabBarController()
    }

    func start() {

        let homeNavigationController = UINavigationController()
        let homeCoordinator = HomeCoordinator(homeNavigationController)
        homeCoordinator.start()
        store(coordinator: homeCoordinator)

        let catalogNavigationController = UINavigationController()
        let catalogCoordinator = CatalogCoordinator(catalogNavigationController)
        catalogCoordinator.start()
        store(coordinator: catalogCoordinator)

        tabBarController.viewControllers = [homeNavigationController, catalogNavigationController]
        navigationController.viewControllers = [tabBarController]
    }
}

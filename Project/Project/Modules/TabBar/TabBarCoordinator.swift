//
//  TabBarCoordinator.swift
//  Project
//
//  Created by user on 15.08.2022.
//

import UIKit

final class TabBarCoordinator: Coordinator {
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

		let cartNavigationController = UINavigationController()
		let cartCoordinator = CartCoordinator(cartNavigationController)
		cartCoordinator.start()
		store(coordinator: cartCoordinator)

		let userProfileNavigationController = UINavigationController()
		let userProfileCoordinator = UserProfileCoordinator(userProfileNavigationController)
		userProfileCoordinator.start()
		store(coordinator: userProfileCoordinator)

        tabBarController.viewControllers = [
			homeNavigationController,
			catalogNavigationController,
			cartNavigationController,
			userProfileNavigationController
		]
        navigationController.setViewControllers([tabBarController], animated: false)
    }
}

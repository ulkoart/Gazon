//
//  HomeCoordinator.swift
//  Project
//
//  Created by user on 15.08.2022.
//

import UIKit

protocol HomeFlow {
    func coordinateToInfo()
}

class HomeCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController

    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let homeControler = HomeFactory.createModule()
        homeControler.coordinator = self
        navigationController.pushViewController(homeControler, animated: false)
    }
}

extension HomeCoordinator: HomeFlow {
    func coordinateToInfo() {
        let homeInfoCoordinator = HomeInfoCoordinator(navigationController)
        store(coordinator: homeInfoCoordinator)
        homeInfoCoordinator.isCompleted = { [weak self, unowned homeInfoCoordinator] in
            self?.free(coordinator: homeInfoCoordinator)
        }
        homeInfoCoordinator.start()
    }
}

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

final class HomeCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController

    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let homeControler = HomeFactory.createModule()
        let viewModel = HomeViewModelImpl()
        homeControler.coordinator = self
		homeControler.viewModel = viewModel
        navigationController.pushViewController(homeControler, animated: false)
    }
}

extension HomeCoordinator: HomeFlow {
    func coordinateToInfo() {
        let homeInfoCoordinator = HomeInfoCoordinator(navigationController)
        store(coordinator: homeInfoCoordinator)

        homeInfoCoordinator.isCompleted = { [weak self, weak homeInfoCoordinator] in
            self?.free(coordinator: homeInfoCoordinator)
        }
        homeInfoCoordinator.start()
    }
}

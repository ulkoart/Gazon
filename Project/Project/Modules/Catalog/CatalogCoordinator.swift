//
//  CatalogCoordinator.swift
//  Project
//
//  Created by user on 15.08.2022.
//

import UIKit

final class CatalogCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController

    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let catalogFactory = CatalogFactory.createModule()
        navigationController.pushViewController(catalogFactory, animated: false)
    }
}

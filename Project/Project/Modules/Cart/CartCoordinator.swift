//
//  CartCoordinator.swift
//  Project
//
//  Created by Улько Артем Викторович on 17.08.2022.
//

import UIKit

final class CartCoordinator: Coordinator {
	var childCoordinators: [Coordinator] = []
	var navigationController: UINavigationController

	init(_ navigationController: UINavigationController) {
		self.navigationController = navigationController
	}

	func start() {
		let catalogFactory = CartFactory.createModule()
		navigationController.pushViewController(catalogFactory, animated: false)
	}
}

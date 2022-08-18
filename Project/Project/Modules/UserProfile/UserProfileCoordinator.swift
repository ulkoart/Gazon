//
//  UserProfileCoordinator.swift
//  Project
//
//  Created by Улько Артем Викторович on 17.08.2022.
//

import UIKit

final class UserProfileCoordinator: Coordinator {
	var childCoordinators: [Coordinator] = []
	var navigationController: UINavigationController

	init(_ navigationController: UINavigationController) {
		self.navigationController = navigationController
	}

	func start() {
		let catalogFactory = UserProfileFactory.createModule()
		navigationController.pushViewController(catalogFactory, animated: false)
	}
}

